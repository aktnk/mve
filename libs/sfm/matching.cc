#include <iostream>

#include "math/algo.h"
#include "nearestneighbor.h"
#include "matching.h"

SFM_NAMESPACE_BEGIN

void
remove_inconsistent_matches (MatchingResult* matches)
{
    for (std::size_t i = 0; i < matches->matches_1_2.size(); ++i)
        if (matches->matches_2_1[matches->matches_1_2[i]] != (int)i)
            matches->matches_1_2[i] = -1;
    for (std::size_t i = 0; i < matches->matches_2_1.size(); ++i)
        if (matches->matches_1_2[matches->matches_2_1[i]] != (int)i)
            matches->matches_2_1[i] = -1;
}

SFM_NAMESPACE_END