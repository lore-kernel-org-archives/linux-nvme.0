Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CDECFD341
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 10:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iVdwdXLcGb2q0rf5SRvZU0OjGnAMTbfIf2u+EEETFNM=; b=tjniUEQpb88ExlVP3WnYNZxbSA
	SwQPrFWf1dLNcQqf58swulEVG1nNhEN0jalnwKZVdtfcfSY1uV1wkmQAapbuAwHbNUkRKPjZZIJcZ
	gBKIykWSIZZ3xusSWSlnR7j8Ln+Xi7IqiRqLcsEZ8BTvxrrxaN5L4XeupiWqYePi/La8ZopcmBbzw
	hR+r0tqYAMIuOeAiF01dEaeziES43DKWR7VYBhZ7ovI7KtbWWQi4js6fm8ZnUQbdxZhZRXOzFP9TF
	om9FDinL41TJFKd86Tzf636wtxj6w2LYjZWDgABwBb2/PGctB1PCjrgATenvjWVgfQUp8WInijmZB
	YGM/+Xxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szDMU-0000000G4mC-0BUc;
	Fri, 11 Oct 2024 10:59:10 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szDII-0000000G41b-0vgW
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 10:54:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728644086; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=iVdwdXLcGb2q0rf5SRvZU0OjGnAMTbfIf2u+EEETFNM=;
	b=xsZguTZJCTijGI1KarQziwdlcMeyxQl8RHBph6N10NDWsTJysJfyeWPsddgyZ0Xrzps9DHOVc03x6z0xFBihGUC/QopOFUIaRMe1Uptuc9sUAQpY8ExxAz6nxQqVYiGLo4+b4lJDI5py5Mw8u40qXXJsprwYxad3tT7TG66a5Zs=
Received: from 30.178.81.214(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WGq9emE_1728644083 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 18:54:44 +0800
Message-ID: <18ee6bc5-7025-44af-9fce-59e4fcc407cf@linux.alibaba.com>
Date: Fri, 11 Oct 2024 18:54:43 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvmetcli: reservation configuration support
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, d.bogdanov@yadro.com
Cc: linux-nvme@lists.infradead.org
References: <20241008080800.7712-1-kanie@linux.alibaba.com>
In-Reply-To: <20241008080800.7712-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_035450_960258_AB8B5681 
X-CRM114-Status: GOOD (  11.24  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

gentel ping..

Best Regards,

Guixin Liu

在 2024/10/8 16:08, Guixin Liu 写道:
> Add support for reservation configuration.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   nvmet/nvme.py | 2 +-
>   nvmetcli      | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
> index 59efdb5..20b3cca 100644
> --- a/nvmet/nvme.py
> +++ b/nvmet/nvme.py
> @@ -567,7 +567,7 @@ class Namespace(CFSNode):
>               if nsid < 1 or nsid > self.MAX_NSID:
>                   raise CFSError("NSID must be 1 to %d" % self.MAX_NSID)
>   
> -        self.attr_groups = ['device', 'ana']
> +        self.attr_groups = ['device', 'ana', 'resv']
>           self._subsystem = subsystem
>           self._nsid = nsid
>           self._path = "%s/namespaces/%d" % (self.subsystem.path, self.nsid)
> diff --git a/nvmetcli b/nvmetcli
> index d949891..6e5348f 100755
> --- a/nvmetcli
> +++ b/nvmetcli
> @@ -283,6 +283,8 @@ class UINamespaceNode(UINode):
>               info.append("nguid=" + ns_nguid)
>           if self.cfnode.grpid != 0:
>               info.append("grpid=" + str(self.cfnode.grpid))
> +        resv_enable = self.cfnode.get_attr("resv", "enable")
> +        info.append("resv_enable=" + str(resv_enable))
>           info.append("enabled" if self.cfnode.get_enable() else "disabled")
>           ns_enabled = self.cfnode.get_enable()
>           return (", ".join(info), True if ns_enabled == 1 else ns_enabled)

