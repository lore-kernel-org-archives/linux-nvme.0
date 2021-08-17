Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958B2C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 16:14:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFA160E90
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 16:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5FFA160E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KgD9D+TjtaCSamdrdOwQ5Lw5kdBjNFbWiUrnB43y7+8=; b=VqrfKnw8sY9AJq
	xTeoQllACg6oDgaJN9a4rTcZkMM9idnhJepRmNaME2RpV1tGZHGxNqTKQ6SOatgD4OieVoAKEXZJU
	h5Ay6zrn+nJ/T7Dg3h3h8IZB33S9ObuhN62GVoo7OnfKf1T91w0o4k03z67USD4EnDHba2H0/wUde
	i53zUgH34rmhBGzpiJC3Q0YLub1V6WD3tV0GOldBK8+2f242xt5xH5gj73FkV+u0cYqz7fajWj2jB
	YbnJe9aoIsqg/u3TdjXt/zkDX+JeJ6qSe/LMlkliGKZ916F0FaOR7NFdsHxMB/MC92bpi4Q3THZXp
	XAgTKdowBKIgsqD/KTkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG1j3-002vfT-Q6; Tue, 17 Aug 2021 16:14:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG1j1-002vfB-HN
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 16:14:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0ABA60E90;
 Tue, 17 Aug 2021 16:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629216843;
 bh=TqOOMzSDA2v5s25YknGAAlPkxD193QPH38MuLdzzxPk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jWGcKiczNVIU8nCNHPQrActEyxrbnX09tEq86yGv0DFRMNs2I8D916yR59gW3LHwd
 pboSja5Xu26vvz7931Icf5AQTTx0T5wJi7R87ugFkyPfWXcbGmJBO5Ed5kS/8S7D29
 v9iBU+PYA4wLeQXR1yBplZQaBhBdLt8yIIzW+sDvM/K1+hmkX68dkXOSMrDLHqFyI6
 dkxp1yoybuZMZt+LaTaIGGOdnXc6YShjP3YddWl5w1baEOPthSNklOysdmiRm5mFGa
 ohK6Z1sritlsbn6BF8EeATRt5R4OU+oA00XCG/N0UeTkHdJhYg8ZFo91tNBbWpXZ8x
 lD4DSfKIeuo6A==
Date: Tue, 17 Aug 2021 09:14:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: chengjike <chengjike.cheng@huawei.com>
Cc: linux-nvme@lists.infradead.org, sunao.sun@huawei.com,
 liuzhouhua@huawei.com, lengchao@huawei.com, jiangtao62@huawei.com
Subject: Re: [PATCH nvme-cli 0/3] nvme-cli/plugins/huawei: display the status
 of each disk
Message-ID: <20210817161400.GB223727@dhcp-10-100-145-180.wdc.com>
References: <20210817150715.1173-1-chengjike.cheng@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210817150715.1173-1-chengjike.cheng@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_091403_631774_CC1EEE62 
X-CRM114-Status: UNSURE (   8.82  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 17, 2021 at 11:07:12PM +0800, chengjike wrote:
> Hi, I'd like to display the current status of each disk when I execute the command "nvme huawei list". 
> Two bugs were also fixed in order to be able to display status.

There is nothing huawei specific about any of this, can't we just make
the generic list commands display this kind of stuff?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
