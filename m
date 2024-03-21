Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F88C54E58
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 21:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DXO+f7Oy+hDoLR/eGyl4paU02AEWtHJimm0/YPHMB9g=; b=f1WzKeYogQ2puJv1zOUdx7hu5n
	h0bULPMCAL+AJpLjoRcEKk2xjnVQVqSGNc7JdtzhF9OmK/6/s5QoFgNI1k7QGDZShcNJBkEe0k83c
	MWAs+P3qG0eoDH+UuKLehOqoFJl7IiI0bylNUMRHyxBctcwNco+rcqsH2OFxbBMSdSezoDyK8XdE7
	J7Cou1jaK2VGHTaZAoG+SivT74AkcMGfREHIh2SrfP2AwGiocP+3DHJq13mf9FrfvJ4VUOk9ZxsHY
	kizG7wXVHbxMyzqI64UdcUthZxmEevMu//16nWiVy+QdPZGeUWi2sZRua7PbdEhd0Sp4vf8d9NsPs
	xIYeuQVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnPYD-00000004cME-06jx;
	Thu, 21 Mar 2024 21:02:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnPYA-00000004cL0-0VNZ
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 21:02:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 977EB68B05; Thu, 21 Mar 2024 22:02:05 +0100 (CET)
Date: Thu, 21 Mar 2024 22:02:05 +0100
From: "hch@lst.de" <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "hch@lst.de" <hch@lst.de>, Guixin Liu <kanie@linux.alibaba.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Message-ID: <20240321210205.GC21139@lst.de>
References: <47f18beb-3647-4464-9f2c-b75e10ec346b@grimberg.me> <2eb0672e-1073-497b-94ce-f3c356b7580e@linux.alibaba.com> <9983f5a2-6abb-41c8-89a7-aad32e247500@grimberg.me> <8d157341-0f64-4c91-b3d0-d3d5669c9e20@linux.alibaba.com> <99f5f33b-2c68-4c93-ad4d-333a05cb4d09@grimberg.me> <a134b972-0254-4f1e-91b9-a57223201f42@linux.alibaba.com> <cea98ed9-6b65-4475-8497-62f1ca9f81a3@nvidia.com> <b691ccf2-3627-402c-bb68-eb3fc8845e41@linux.alibaba.com> <20240320015932.GA14551@lst.de> <ef50ec40-dc7f-42fd-b84d-c0842a8392b4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef50ec40-dc7f-42fd-b84d-c0842a8392b4@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_140210_602824_7CA867CE 
X-CRM114-Status: GOOD (  10.05  )
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

On Wed, Mar 20, 2024 at 11:16:29AM +0200, Sagi Grimberg wrote:
> That's a neat idea, we also have file to think about though.

Indeed.  It still would be good to avoid the extra overhead when not
needed, though.

