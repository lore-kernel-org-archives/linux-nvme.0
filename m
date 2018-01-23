From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 23 Jan 2018 09:43:04 +0800
Subject: [PATCH] nvme-pci: ensure nvme_timeout complete before
 initializing procedure
In-Reply-To: <20180122215436.GS12043@localhost.localdomain>
References: <1516607585-1525-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180122201423.GA30427@lst.de>
 <20180122215436.GS12043@localhost.localdomain>
Message-ID: <a3fc1646-37cc-7c15-0085-35a320d0a3b8@oracle.com>

Hi Christoph and Keith

Really sorry for this.

On 01/23/2018 05:54 AM, Keith Busch wrote:
> On Mon, Jan 22, 2018@09:14:23PM +0100, Christoph Hellwig wrote:
>>> Link: https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2018_1_19_68&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=xJVh7u7o8UBQko2JJRmxqldiuMhaIosNJN8WTkhAF98&s=uk1TvCGpW928A4GMJh1tvxNvPiVfgJvFjjPn69f8fNA&e=
>>> Suggested-by: Keith Busch <keith.busch at intel.com>
>>> Signed-off-by: Keith Busch <keith.busch at intel.com>
>>> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
>>
>> Why does this have a signoff from Keith?
> 
The the nvme_sync_queues is from Keith in the mail thread, so I added this.
I will discard it and just reserve "suggested-by" later.

> Right, I hadn't signed off that. I just trying to get feeback if
> someting like that was closing the theoretical gap, which it does.

Yes.

> 
> I actually have something similar in my patch queue I was about to send
> around this area, though. I don't like having the IO path take on the
> error handling, and I think ending unstarted requests directly will be
> better long term.
Yes.

Many thanks for your kindly response.


Thanks
Jianchao
