Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8965CC7EE23
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yCDzj21CfLVCh4y4uoYZaN75mx/cS0V7OtJmKLAFe+k=; b=gVAwmP/QHwDeI7/RzooBYIsrCG
	szrvDUYgxJgGYcurhpI5S2juSFQhrOMNpr8fI8yvQjtusCLUQel3YQGJs21mWofnrwuEKdLkBdz6l
	NsJT2DrnyeSeCzErgGida2EJQVwEUb/xVwpPBId/2J9bPTwko//pIl37rSQlcpq5ahVbevxmQExjM
	fGWTQ3dNnj6yzBTnzrstVIT3IVO9cwzO2nU2gH4LVIMW3jAWEqiAiPlQV9dICXkrpHemZAX3Q0v4L
	WnvyiQyNt/nxglqksiLDEQ2MxqBpzBrx26uQCiPSXJ+XGov2UOI2Ogk6IjswrTiqPyqKMATvm/OEf
	7hyIraQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q426c-00EYIy-1c;
	Tue, 30 May 2023 16:21:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q426Z-00EYIK-2i
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 16:21:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 09B6361136;
	Tue, 30 May 2023 16:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C879CC433EF;
	Tue, 30 May 2023 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685463710;
	bh=yCDzj21CfLVCh4y4uoYZaN75mx/cS0V7OtJmKLAFe+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCNVVzKn0I6Gobf86vMwPUnwk2qMLtcAp67EAUIh4r6t/JYCNC5n8GVsNcbjua7Mk
	 Ari+6UhyjwfQ0n+4j1QcV9xY2e6257T/DTfT9kcFhckZxpON0IvwiI9cRXkDmaBeDY
	 uqB4n+WX6Hn26ekCdRoLrNZUmg3OE85Xxw7b6R53BM8fcZwEeBE1wt6XohDFNYAsd+
	 r5NVFOibtiKGenfWKAnUDTw7Drpi5t39twOiHIBnt2BxFsSnGd3ZnYVrpEohyq0oDb
	 JR1mtPK+4d4477ErYPKlNEXbPiPCC2b68Xf/orlIGhVSMtpTuloZtcZ+4nlpnkiofw
	 aS9W4JIMXVwzQ==
Date: Tue, 30 May 2023 10:21:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v6 0/3] keepalive bugfixes
Message-ID: <ZHYim1LGb5qAXdaN@kbusch-mbp.dhcp.thefacebook.com>
References: <20230525182204.1954429-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525182204.1954429-1-ushankar@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_092151_917155_C5446AE3 
X-CRM114-Status: UNSURE (   7.97  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, applied for nvme-6.4.

