From: bdeyal@gmail.com (Eyal BenDavid)
Date: Tue, 19 Jun 2018 23:55:13 +0300
Subject: NVME-CLI : Fabrics property-get and 64 bit property (CAP)
In-Reply-To: <20180619202514.GG19922@localhost.localdomain>
References: <CAPrnrPD2PtPO38cAzMfKdhS18GFj1vk032p0h0rQf0CFP+R=cw@mail.gmail.com>
 <e75d7829-9aeb-90fb-249a-c7ac4cef10bd@intel.com>
 <CAPrnrPBKcYUsuQ6krkcjB6BOzLcPz47vje4qjic5Xw9PQN3pTQ@mail.gmail.com>
 <20180619194802.GF19922@localhost.localdomain>
 <CAPrnrPCM79jUwngOQd0t6-pT3RocHNBnt_TS059d+NK-rodqDA@mail.gmail.com>
 <20180619202514.GG19922@localhost.localdomain>
Message-ID: <CAPrnrPA2rUeWsrU5K_s9do30EjuxU3Z0VD_EVCk_81+n-kX+gQ@mail.gmail.com>

On Tue, Jun 19, 2018 at 11:22 PM Keith Busch
<keith.busch@linux.intel.com> wrote:

> Yeah, you should be able to see it if you've a recent enough kernel with
> event tracers enabled. First enable the tracing:
>
>   echo 1 > /sys/kernel/debug/tracing/events/nvme/enable
>
> Then after running your nvme command, you should see the result with:
>
>   cat /sys/kernel/debug/tracing/trace

Thanks :-)
Eyal
