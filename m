From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 21 Feb 2017 11:59:12 -0700
Subject: [PATCHv4 0/4] OPAL patches, cont'd
Message-ID: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>

v3->v4:
Passes in 'lock_held' into opal_lock_unlock() so we don't need to
mutex_trylock(). I wasn't totally confident in that approach anyways.

v2->v3:
Squashed 5/5 into 4/5
Changed opal_step structs back to const
Cleaned up opal_lock_unlock

v1->v2:
Moved misplaced code from 5/5 to 4/5

The first three in the series have been reviewed already but I wanted to
squash them with the last patch since they haven't been pulled yet.

The last patch is an attempt to refactor some of the awkward func data
and state separation into a common struct

Jon Derrick (4):
  block/sed: Use ssize_t on atom parsers to return errors
  block/sed: Add helper to qualify response tokens
  block/sed: Check received header lengths
  block/sed: Embed function data into the function sequence

 block/sed-opal.c | 552 +++++++++++++++++++++++--------------------------------
 1 file changed, 227 insertions(+), 325 deletions(-)

-- 
1.8.3.1
