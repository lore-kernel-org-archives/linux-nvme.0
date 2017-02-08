From: jsmart2021@gmail.com (James Smart)
Date: Tue, 7 Feb 2017 18:32:30 -0800
Subject: [PATCH v2 07/18] lpfc: NVME Initiator: Base modifications Part E
In-Reply-To: <5881e84b-c932-f812-7f41-a16152d12106@suse.de>
References: <58990208.nZVFaqC7RkseErlq%jsmart2021@gmail.com>
 <5881e84b-c932-f812-7f41-a16152d12106@suse.de>
Message-ID: <52f4f81e-2353-4da2-7ce9-a7cd7796e1f7@gmail.com>



On 2/7/2017 1:03 AM, Johannes Thumshirn wrote:
>
> Yes but patch  03/18 'lpfc: NVME Initiator: Base modifications Part A'
> still has calls to lpfc_sli_hbq_count(phba) (and in fact introduces this
> change).
>

I realize I cut these in a silly way.  In the v1 patches, I had a big 
patch that I then cut into 6 parts, by file.  In the v2 patches, I tried 
to keep the patches as is, and address the comments in the respective 
patch the comment came from. Which resulted in 3/8 with an old 
reference, but patch 8/8 being the one that reverted this reverence. 
Sorry..  I'll recut and repost.

-- james
