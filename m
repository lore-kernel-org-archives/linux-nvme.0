From: zhangweiping@didichuxing.com (=?gb2312?B?1cXOsMa9KLv5tKHGvcyosr8p?=)
Date: Wed, 28 Jun 2017 00:48:43 +0000
Subject: [PATCH] nvme: remove indenty ctrl before scan namespace
In-Reply-To: <20170627194753.GC23962@localhost.localdomain>
References: <20170627152336.GA36545@localhost.didichuxing.com>,
 <20170627194753.GC23962@localhost.localdomain>
Message-ID: <2E3A4E1D-9176-467D-8FAE-FEB56ECC8A0F@didichuxing.com>

You are right, thanks.

> ? 2017?6?28??03:39?Keith Busch <keith.busch at intel.com> ???
> 
>> On Tue, Jun 27, 2017@11:23:36PM +0800, weiping zhang wrote:
>> All nvme host drivers have already identified ctrl beforce scan namespace,
>> so when first time identify ctrl we get the number of namespace and store it
>> into nvme_ctrl. When we scan namespace just use it instead of indentify again.
> 
> The scan work can be schedule in more than just the reset path, though,
> which is where ID ctrl is initialized. In those cases, attaching
> namespaces may stop working.
