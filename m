Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684C7CA0EE6
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p/ooT7CZSow5ebldsF91hMh8ZoThr7AYcU58h8a0xZs=; b=FuEWzh8XdkhIApbdIOswjI9A2n
	ThUPIB2m6STpKCePVuv6mcymtBc8gcexYv5kV52gEzxb+f/R+N174Y6P4Z2XwpmyUwZyDVdJVck70
	AhK5BH14UeywzmmnUOogiV9k5vQkN7EmwxBdezWugj5qN1vTRVclcKWuXldRgGpD35S5A6ElR6cYY
	Eoofoyt/iheHcRmXGyBOVow/hoB/VVg49PinIyDssrcEOJmsAUW8mGBB0glpa9th/148TEfsdAVzG
	noJGlUkpSaUtXWrskP6EFVafnJ7YlL9OVtAWwX9xgLGFrehVjT4gkjeugbJSHQcFEiRJxyWpEokVo
	te31huVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoQpU-0000000BByj-33WN;
	Tue, 19 Aug 2025 18:13:04 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoM8i-0000000AYA5-2V3i
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 13:12:38 +0000
Received: from localhost (<unknown> [193.207.151.114])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id ba7ee5b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Aug 2025 15:12:30 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 15:12:27 +0200
Message-Id: <DC6FI49WALCL.Q2W75P781CG5@bsdbackstore.eu>
Cc: <linux-nvme@lists.infradead.org>
Subject: Re: Unable to reconnect namespace via NVMe/TCP
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Chris Leech" <cleech@redhat.com>, "Anton Gavriliuk"
 <antosha20xx@gmail.com>
X-Mailer: aerc
References: <CAAiJnjqKqMHjrPLOvY5sCXiQR0n6pMvm2mS5pQEqy2XY1cD_6Q@mail.gmail.com> <aKOT88cdjI2OYi4e@my-developer-toolbox-latest>
In-Reply-To: <aKOT88cdjI2OYi4e@my-developer-toolbox-latest>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_061236_982918_A2843581 
X-CRM114-Status: GOOD (  12.82  )
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

On Mon Aug 18, 2025 at 10:58 PM CEST, Chris Leech wrote:
> On Tue, Aug 12, 2025 at 06:48:29PM +0300, Anton Gavriliuk wrote:
>> Hi
>>=20
>> There are NVMe/TCP target and initiator servers, both running on
>> RHEL10 (6.12.0-55.25.1.el10_0.x86_64)
>>=20
>> NVMe/TCP target exports single NVMe SSD
>>=20
>>       "namespaces": [
>>         {
>>           "device": {
>>             "nguid": "01000000-0000-0000-8ce3-8ee3064aa4f2",
>>             "path": "/dev/nvme0n1"
>>           },
>>           "enable": 1,
>>           "nsid": 1
>>         }
>>       ],
>>=20
>> If NVMe/TCP target is not available, initiator tries to reconnect
>> every 10 seconds
>
> How is the target becoming unavailable?  Is it as network interruption,
> or is the target being rebooted or reconfigured?
>
> Is the shared snippet the entire "namespaces" section of the
> configuration file?
>
> It looks like the target code will generate a random uuid for a device
> when it's configured, which could then trip up the host attempting to
> reconnect across a target reboot. But I think the uuid can be saved as
> well as the nguid in the target configuration.

Indeed, normally, nvmetcli saves the uuid in the config file.

Maurizio

