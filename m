From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 13 Feb 2018 10:21:24 +0800
Subject: [PATCH 1/3] nvme-pci: Fix timeouts in connecting state
In-Reply-To: <20180212141818.GA16255@localhost.localdomain>
References: <20180209174127.7224-1-keith.busch@intel.com>
 <ec9b47c4-3c83-6f00-bf2d-8eae5484a649@oracle.com>
 <20180212141818.GA16255@localhost.localdomain>
Message-ID: <58a6237f-53ab-c0bf-2739-08fc3a45cdd1@oracle.com>

Hi Keith

Thanks for your kindly response.

On 02/12/2018 10:18 PM, Keith Busch wrote:
> On Sat, Feb 10, 2018@10:14:46AM +0800, jianchao.wang wrote:
>> This patch should be merged with the 3th one.
> 
> Why? This one fixes a regression introduced in the merge window, the
> other is fixes something entirely different.
> 

This patch could not fix the issue totally, it will not work well with
your 3rd patch.

Thanks
Jianchao
