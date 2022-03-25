#include "limits.isph"
#include "argmax.isph"

// Returns the index corresponding to the maximum value in x.
uniform size_t argmaxf(varying float x, varying size_t index)
{
    uniform size_t ret = 0;
    uniform float ret_max = FLT_LOWEST;

    for (uniform int j = 0; j < programCount - 1; j++)
    {
        if (extract(x, j) > ret_max) 
        {
            ret_max = extract(x, j);
            ret = extract(index, j);
        }
    }

    return ret;
}

// Returns the index corresponding to the maximum value in x.
uniform size_t argmax(varying double x, varying size_t index)
{
    uniform size_t ret = 0;
    uniform double ret_max = DBL_LOWEST;

    for (uniform int j = 0; j < programCount - 1; j++)
    {
        if (extract(x, j) > ret_max) 
        {
            ret_max = extract(x, j);
            ret = extract(index, j);
        }
    }

    return ret;
}