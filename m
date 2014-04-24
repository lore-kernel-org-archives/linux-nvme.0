From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 24 Apr 2014 09:58:05 -0400
Subject: Cmd - comp write
In-Reply-To: <7212DDF9-6821-4D7E-BD4D-655031AD03F7@gmail.com>
References: <7212DDF9-6821-4D7E-BD4D-655031AD03F7@gmail.com>
Message-ID: <20140424135805.GA5886@linux.intel.com>

On Wed, Apr 23, 2014@08:37:39PM -0700, Learner wrote:
> Hello
> 
> How frequently is Fused command - compare-write used? 
> Is it for avoiding writes for SSDs if thee is no change? Ie read and compare the block to be written and don't write if there is no change.. 

Compare-and-Write is a building block for an (unspecified, advisory)
locking protocol.  If two entities wish to gain exclusive access to a
range of LBAs, they can agree on a block to use as their lock, and agree
on a bit-pattern to be found in that block to indicate 'unlocked'.

If anyone is using it, they're doing so through ioctls; there's no way
to submit a BIO that maps to a compare-and-write.
