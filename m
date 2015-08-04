From: havenyang@126.com (HavenYang)
Date: Tue, 4 Aug 2015 11:29:47 +0800 (CST)
Subject: what time does host will re-used the prplist memory region.
Message-ID: <e06add8.1a3fb.14ef6c204d6.Coremail.havenyang@126.com>


Dear all

There is a description from nvme specification 1.2 as following(Figure 26, Completion Queue Entry DW2):

SQ Head Pointer (SQHD): Indicates the current Submission Queue Head pointer for the Submission Queue indicated in the SQ Identifier field. This is used to indicate to the host the Submission Queue entries that have been consumed and may be re-used for new entries.
Note: The value returned is the value of the SQ Head pointer when the completion queue entry was created. By the time host software consumes the completion queue entry, the controller may have an SQ Head pointer that has advanced beyond the value indicated.

It says the SQhead indicate Submission Queue entries may be re-used, but it not say the PRPlist related to this command may be re-used or not, I confused.

my question is:
1. from host side,?what is the condition can host re-used the prplist memory region for a host command, SQHead or command complete?
2. from device side, what is the condition to update SQHead, fetched command head(simple) or fetched all prp from prplist(complex)?


Beset Regards
Haven(havenyang at 126.com)
