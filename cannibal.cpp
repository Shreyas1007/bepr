#include<iostream>
#include<iomanip>
using std::cout;



/* Variables are as follows:
 * im and ic = initial missionaries and cannibal respectfully
 * fm and fc = final missionaries and cannibal respectfully
 * status = indicates what side we are on
 * select = used in solution() method to determine the boat grouping
 * flag = used to determine boat's current location
 * i = loop counter
 */
int im = 3, ic = 3, i, fm = 0, fc = 0, status = 0, flag = 0, select = 0;

/**
 * Formats the output as follows:
 * FINAL GROUP ~~~~~WATER~~~~~<BO(no. of M or C on trip)AT> INITIAL GROUP
 * FINAL GROUP <BO(no. of M or C on trip)AT>~~~~~WATER~~~~~ INITIAL GROUP
 * @@parm bpass1 && bpass2 - passengers for the boat. Can be C, M, or ' '
 */
void display(char bpass1, char bpass2)
{
    cout << "\n\n\n";
    for (int i = 0; i < fm; i++) 
        cout << " M "; 
    for (int i = 0; i < fc; i++)
        cout << " C "; 

    if (flag == 0)
        cout << "     ~~~~~WATER~~~~~<B0(" << bpass1 << "," << bpass2 << ")AT>  ";
    else
        cout << "     <BO(" << bpass1 << "," << bpass2 << ")AT>~~~~~WATER~~~~~  ";
    for (int i = 0; i < im; i++)
        cout << " M ";
    for (int i = 0; i < ic; i++)
        cout << " C ";
}

/**
 * Determines if the game is in a won state or not
 * @@return: 0 if game is won, 1 otherwise
 */
int win()
{
    return (fc == 3 && fm == 3) ? 0 : 1;
}

/**
 * The main solver for the game. Basic algorithm is as follows:
 * 1 - Get boat's current location
 * 2 - Determine passenger grouping
 * 3 - Make trip
 * 4 - Determine if we won
 * 5 - Repeat until we won
 */
void solution()
{
    while (win())
    {
        if (!flag)
        {
            switch (select)
            {
                case 1: display('C', ' ');
                        ic++;
                        break;
                case 2: display('C', 'M');
                        ic++; im++;    
                        break;   
            }
            
            if (((im - 2) >= ic && (fm + 2) >= fc) || (im - 2) == 0)
            {
                im = im - 2;
                select = 1;
                display('M', 'M');
                flag = 1;
            }
            else if ((ic - 2) < im && (fm == 0 || (fc + 2) <= fm) || im == 0)
            {
                ic = ic - 2;
                select = 2;
                display('C', 'C');
                flag = 1;
            }
   
            else if ((ic--) <= (im--) && (fm++) >= (fc++))
            {
                ic = ic - 1;
                im = im - 1;
                select = 3;
                display('M', 'C');
                flag = 1;
            }
        }
  
        else
        {
            switch (select)
            {
                case 1: display('M', 'M');
                        fm = fm + 2;
                        break;
                
                case 2: display('C', 'C');
                        fc = fc + 2;
                        break;   
                
                case 3: display('M', 'C');
                        fc = fc + 1;
                        fm = fm + 1;
                        break;
            }
   
            if (win())
            {
                if (((fc > 1 && fm == 0) || im == 0))
                {
                    fc--;
                    select = 1;
                    display('C', ' ');
                    flag = 0;
                }
                
                else if ((ic + 2) > im)
                {
                    fc--; fm--;
                    select = 2;
                    display('C', 'M');
                    flag = 0;
                }
            }
        }
    }
}

/**
 * The driver of the application.
 * Just prints beginning menu and calls our functions to get us going.
 * @@return 0 indicating successful run.
 */
int main()
{
    cout << "MISSIONARIES AND CANNIBAL SOLUTION";
    display(' ', ' ');
    solution();
    display(' ', ' ');
    return 0;
}
