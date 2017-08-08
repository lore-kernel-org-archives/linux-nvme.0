From: dledford@redhat.com (Doug Ledford)
Date: Tue, 08 Aug 2017 15:14:36 -0400
Subject: [PATCH v8 0/7] Automatic affinity settings for nvme-rdma
In-Reply-To: <20170713085700.GL1528@mtr-leonro.local>
References: <1499933384-17407-1-git-send-email-sagi@grimberg.me>
 <20170713082041.GK1528@mtr-leonro.local>
 <d3e93dfa-79c0-22c5-eacd-a8699b924de8@grimberg.me>
 <20170713085700.GL1528@mtr-leonro.local>
Message-ID: <1502219676.3002.11.camel@redhat.com>

On Thu, 2017-07-13@11:57 +0300, Leon Romanovsky wrote:
> On Thu, Jul 13, 2017@11:28:22AM +0300, Sagi Grimberg wrote:
> > 
> > > > Doug, please consider this patch set for inclusion.
> > > 
> > > On which branch did you base your code?
> > 
> > Linus 4.12 + block tree updates.
> 
> Thanks

Hi Sagi,

I've pulled this into a branch and pushed it to my github for 0day
testing.  There were a number of conflicts, so please double check that
my branch is resolved out the way you want.  Thanks.

-- 
Doug Ledford <dledford at redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
