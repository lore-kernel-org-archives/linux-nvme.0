From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Jul 2017 12:09:17 -0400
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <e78bec7c-6393-a527-99df-3eb71245fb6d@broadcom.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-8-git-send-email-keith.busch@intel.com>
 <6e6d624b-4749-7b72-9ebc-58ba328adc64@broadcom.com>
 <20170711144353.GB4604@localhost.localdomain>
 <e78bec7c-6393-a527-99df-3eb71245fb6d@broadcom.com>
Message-ID: <20170713160917.GH8388@localhost.localdomain>

On Tue, Jul 11, 2017@10:14:20AM -0700, James Smart wrote:
> On 7/11/2017 7:43 AM, Keith Busch wrote:
> > I agree that usage for dynamic strings is better, but this is a fixed
> > sized string that will always be 20 bytes.
> 
> My scenario was the same - fixed sized, not dynamic.  Just being the
> messenger for consistency.

Wha?! That style point is not one I'm convinced is better. Not only is
it more complicated, the stack overhead of calling kasprintf is higher
than the 20 bytes I'm using here.
