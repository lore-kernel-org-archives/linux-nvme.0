From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Fri, 12 Jan 2018 09:31:21 +0800
Subject: [PATCH] nvme-pci: calculate iod and avg_seg_size just before use
 them
In-Reply-To: <20180111154857.GA2602@localhost.localdomain>
References: <1515647379-1877-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180111154857.GA2602@localhost.localdomain>
Message-ID: <6a128c20-bf35-8526-224c-7e0de88d0908@oracle.com>

Hi Keith

Thanks for your kindly response.

On 01/11/2018 11:48 PM, Keith Busch wrote:
> On Thu, Jan 11, 2018@01:09:39PM +0800, Jianchao Wang wrote:
>> The calculation of iod and avg_seg_size maybe meaningless if
>> nvme_pci_use_sgls returns before uses them. So calculate
>> just before use them.
> 
> The compiler will do the right thing here, but I see what you mean. I
> think Christoph has some SGL improvements coming, though, that will
> obviate this.
> 
Yeah, that's great.

Thanks
Jianchao
