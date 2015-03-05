From: keith.busch@intel.com (Keith Busch)
Date: Thu, 5 Mar 2015 15:30:22 +0000 (UTC)
Subject: Testing IO PRP List
In-Reply-To: <54F87539.2050605@ip-maker.com>
References: <54F867BD.6070806@ip-maker.com>
 <alpine.LNX.2.00.1503051451430.32385@localhost.lm.intel.com>
 <54F87539.2050605@ip-maker.com>
Message-ID: <alpine.LNX.2.00.1503051526520.32385@localhost.lm.intel.com>

On Thu, 5 Mar 2015, Olivier Mallinger - IP Maker wrote:
> I will try to test it with an other OS, checking if queue are created with 
> PRP List.
> The best solution would be a PCIe exerciser but I don't have access to such 
> equipment now.

AIUI, the interop lab at UNH has a compliance suite that includes tests
for physically discontiguous IO queues.

https://www.iol.unh.edu/testing/storage/nvme/test-suites

I've never tried it though, so couldn't say how it's used.
