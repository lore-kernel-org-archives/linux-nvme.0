From: keith.busch@intel.com (Keith Busch)
Date: Fri, 25 Jan 2019 09:23:53 -0700
Subject: [PATCH v2 0/4] Write-hint for FS journal
In-Reply-To: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
References: <CGME20190109153328epcas2p4643cbdc7a2182b47893a2bcaa0778e17@epcas2p4.samsung.com>
 <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
Message-ID: <20190125162353.GA11210@localhost.localdomain>

On Wed, Jan 09, 2019@09:00:57PM +0530, Kanchan Joshi wrote:
> Towards supporing write-hints/streams for filesystem journal.                   
>                                                                                 
> Here is the v1 patch for background -                                           
> https://marc.info/?l=linux-fsdevel&m=154444637519020&w=2                        
>                                                                                 
> Changes since v1:                                                               
> - introduce four more hints for in-kernel use, as recommended by Dave chinner   
>   & Jens axboe. This isolates kernel-mode hints from user-mode ones.            

The nvme driver disables streams if the controller doesn't support
BLK_MAX_WRITE_HINT number of streams, so this series breaks the feature
for controllers that only support up to 4.
