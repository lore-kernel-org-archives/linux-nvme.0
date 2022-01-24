Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6370EC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pIbvXdTNUMzCeC0E4NR7IBDzVR1pYTqet6qhv7Gpp2M=; b=MgDXjpIF2LMaCqi4L1nEnEi2FC
	yZP+rK/ZwwMBl8HUXuzQmxbedExwmtPHlfJT9gac2vkrpe4e4xfp2r6Q5e+KMsLxt22SNfUupAqq8
	lvknQPudGi53UmhHMAmtLNNeMNTuSLzASbC+tfOqZSzMPJl2IS/QX6BKq5Ej5ifxFaOMbnLkplt71
	mx+5dlMDVsyFZ4gAZXth+XzgAlRHPpRy/FJGUpZ/+2St+5brN9RA6pmc41iLlOXiRHWk1XyAjnluF
	Ko7zM563/zqy0qLQbnSlQ+P2mYYFO9QgrFlBrvXFzqz2BzBfFYZ9fUOXJgHPJix4iAW/rEl8rwT2l
	UuMI0zLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nC3Ic-004E8p-8x; Mon, 24 Jan 2022 17:38:38 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nC3IY-004E8C-LN
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 17:38:36 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M5Q6n-1nBDwz1zL3-001V82 for <linux-nvme@lists.infradead.org>; Mon, 24 Jan
 2022 18:38:24 +0100
Received: by mail-wr1-f44.google.com with SMTP id k18so14995207wrg.11
 for <linux-nvme@lists.infradead.org>; Mon, 24 Jan 2022 09:38:24 -0800 (PST)
X-Gm-Message-State: AOAM5322CVHemj++0X4dqyeG43JV7+04LnFH+o7th10FYPYTnb61mkdt
 3AgsrTkSugZJUK3XM4ni4M5Dna83x5n4pYkABg8=
X-Google-Smtp-Source: ABdhPJyXZF2Mj32FjIcX5YcSsfFjBiMAv8HzCU2khH2F5s44N81S3irwIWHPo6ztRa/zA18kUOwyvr7pqZEPgvvDxxk=
X-Received: by 2002:adf:fd05:: with SMTP id e5mr15019518wrr.192.1643045904049; 
 Mon, 24 Jan 2022 09:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20220124160107.1683901-1-kbusch@kernel.org>
 <20220124160107.1683901-6-kbusch@kernel.org>
In-Reply-To: <20220124160107.1683901-6-kbusch@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 24 Jan 2022 18:38:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0i87SHhAvG2GuruGgnTzqAuHaEQ0iq9udaMwX56aaw+Q@mail.gmail.com>
Message-ID: <CAK8P3a0i87SHhAvG2GuruGgnTzqAuHaEQ0iq9udaMwX56aaw+Q@mail.gmail.com>
Subject: Re: [RFC 5/7] asm-generic: introduce be48 unaligned accessors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, Coly Li <colyli@suse.de>, 
 Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:P1GLe/I82snOKO3Pp2b+UXUKYZNRmlDRCW+17E2r0cWSqv49pZk
 iCQl6TWI2CrZBVHoxkJszgNK7CgUn0He5rpl12zcOhpJb+L7wnSfyBp/ywjoYGoaRGeOuou
 ZQ9votmfngHe7ycf9uJoFkvTXUYOuoYMlk4teSxNeS7m2s0n1R0cfl6kQ7KmMI14ufQxcop
 yycPcryAFbdYTUef4iaig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z4YGckGZF5o=:CAcViSh+mTaqahMjicc5Nr
 gpPhwb2R8sDXy47+08/fnzJWG1FbPZ9i9wPAGPpl3oMW+EINNKZIdAu1tyIPq/KtnY2B7dngB
 l8d6kYJB8TprDbzHdF24aVc8HI1J1hlvd35pwZ10J5R2GqDvWn/vPOvFAHmxjzcP55El2IOBJ
 +XVj0Qv+MmdOgkmrbE69ci7s4aQOEW8nBh66QuqMa7ITR/79qsX7/smMIbnxGL2NN7QitLaQo
 gHLuuMvLax7ISWtaELoSMCihgCiHreh0Cdzy0NCWDXNM4zOIg/2k33qSlVeIYrAI4AkQvdxoQ
 8UL8Wvcg+UVMIshrDP5rhqPTI6UJFEhb3q1BWgBIJFirTPCdOYI834pe4bgvosrPIIiH0ezM/
 WcPHVCCF863zki+LzwVUJsD+xEKytDdNF8f33ZpgibXtEJ9LRJAeLwjCSh0GMhZ019IXMPosQ
 ZTWxj8FhhKOk0343yY7oH3jemqEU8GagAWlTq8VbX5jciZkJgzV8//q6wKrrYag249wtHW5Cw
 dQmyZQrUVeGOVVt41FEQZDmX0yTu9YhqhJkMZhffK1B+KtduUjcc7M3h9jO1vf+egPDIBo0mE
 B5ldN545aa7KyUwEFRGImMKPLz7VDVn6N9P0iDYgyJo8eOvaAF/yRh3CnEs+8rrEqt1/aHipO
 EslnRUm+W3O+L54cukt4ATISHMl3o47T71uDaGMUAluJ4D9UdJnOZh0n2yq8G2dXWm/I=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_093835_033919_0020BE0D 
X-CRM114-Status: GOOD (  11.32  )
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

On Mon, Jan 24, 2022 at 5:01 PM Keith Busch <kbusch@kernel.org> wrote:
>
> The NVMe protocol extended data integrity fields with unaligned 48-bit
> reference tags. Provide some helper accessors in preparation for these.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

For asm-generic:
Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume you are keeping this together with the rest of the series.

