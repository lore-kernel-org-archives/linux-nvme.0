From: keith.busch@intel.com (Keith Busch)
Date: Wed, 13 Sep 2017 10:34:43 -0400
Subject: [PATCH 01/10] Initial multipath implementation.
In-Reply-To: <20170913054822.pkykbsvyh36uto5f@haynes>
References: <20170912042149.drr5dumro5grm7iu@haynes>
 <20170912160043.GB2832@localhost.localdomain>
 <20170913054822.pkykbsvyh36uto5f@haynes>
Message-ID: <20170913143442.GE2832@localhost.localdomain>

On Tue, Sep 12, 2017@10:48:22PM -0700, Anish Jhaveri wrote:
> On Tue, Sep 12, 2017@12:00:44PM -0400, Keith Busch wrote:
> > 
> > I find this patch series confusing to review. You declare these failover
> > functions in patch 1, use them in patch 2, but they're not defined until
> > patch 7.
> Sorry for late reply. 
> 
> Idea was to keep header file changes as separate patch. 
> I will move the function declaration to patch 7 and 
> rearrange the patch series. If you or anyone else finds 
> something which could help in browsing the changes, I
> will try to incorporate next patchset.

At the very least, you don't want any patch in the series to depend
on a future patch just to compile. There are multiple breakages like
that in your series. For example, patch 5 starts a kthread at function
nvme_mpath_kthread, but that function doesn't exist until patch 8.
