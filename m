From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 17 Feb 2017 17:00:24 -0700
Subject: [PATCHv2 0/5] OPAL patche'd cont'd
Message-ID: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com>

v1->v2:
Moved misplaced code from 5/5 to 4/5

The first three in the series have been reviewed already but I wanted to
squash them with the next two since they haven't been pulled yet.

The latter 2 are an attempt to refactor some of the awkward func data
and state separation into a common struct

Jon Derrick (5):
  block/sed: Use ssize_t on atom parsers to return errors
  block/sed: Add helper to qualify response tokens
  block/sed: Check received header lengths
  block/sed: Embed function data into the function sequence
  block/sed: Eliminate state variable

 block/sed-opal.c | 494 +++++++++++++++++++++++--------------------------------
 1 file changed, 202 insertions(+), 292 deletions(-)

-- 
1.8.3.1
