From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 17 Feb 2017 15:56:13 -0700
Subject: [PATCH 0/5] OPAL patches cont'd
Message-ID: <1487372178-15715-1-git-send-email-jonathan.derrick@intel.com>

The first three in the series have been reviewed already but I wanted to
squash them with the next two since they haven't been pulled yet.

The latter 2 are an attempt to refactor some of the awkward func data
and state separation into a common struct

Jon Derrick (5):
  block/sed: Use ssize_t on atom parsers to return errors
  block/sed: Add helper to qualify response tokens
  block/sed: Check received header lengths
  block/sed: embedded function data into the function sequence
  block/sed: Eliminate state variable

 block/sed-opal.c | 494 +++++++++++++++++++++++--------------------------------
 1 file changed, 202 insertions(+), 292 deletions(-)

-- 
1.8.3.1
