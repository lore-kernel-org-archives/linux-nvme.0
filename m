Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5550BC7EE23
	for <linux-nvme@archiver.kernel.org>; Wed, 31 May 2023 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yCDzj21CfLVCh4y4uoYZaN75mx/cS0V7OtJmKLAFe+k=; b=yTdxxu30g5wzdbeue0/8HQmQWA
	K5WhPI2V7kz0hl8hZIsN4X4AUsVqRLCo2TUQxUmz2rGRxkmE0sgQfX35oxEYhAVtzhOmSmI594JLD
	3On1juuWubwS+VZkNO/fqLpN5A3HaABsA2mAGtc10f71z7yAmnJaBuQYBQ//JxKB0kn8RvXNbBdGz
	O90loMaKzwL7F48TPgjCAZcsWDipZin/Fb63Rmq5FPRbXjAxhHMt1YBpWRQMd4PhO7KXhnMefpdf0
	equOMwtEo4QGEB5IVq4Bw6iGCb/vNMrt74d4KSTXb9Aeb/wwgG9MXvczeOYlet+Zw+ML2hP7iTNyu
	THY3OhLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4Odz-000Slf-1g;
	Wed, 31 May 2023 16:25:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4Odx-000Skr-1S
	for linux-nvme@lists.infradead.org;
	Wed, 31 May 2023 16:25:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0DAF163655;
	Wed, 31 May 2023 16:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E90C433EF;
	Wed, 31 May 2023 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685550345;
	bh=yCDzj21CfLVCh4y4uoYZaN75mx/cS0V7OtJmKLAFe+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsUixLt5zWWLUSVdfvP87nRqPHkbNVyOcGQWKYvkiw0nfHHG7ArGixrXm+923bgCP
	 +DY1BJU/2zIQF6aaAr0bQLgS/fWnUWyeKoa60P7+Pr3//ZGkf1Vs6WQ+Mp2DAa0VLk
	 G1fgnc/9bczHYi4K7syEi/9JsaSU6LglerDdYvpueaSbbVygpdOjKw2M1nSvRIKI5+
	 8AC7KyvBNlLds4I+RMAyaxRSe2a9OSwz/9GOYt4UeHRm5gJLHm5t8wYbIZI08V7TuM
	 hYgT8EHGM/Krf5aZ94CAAu6FXBvK1P6X0cYol/6HVnbFajs/UxuO5WQiOPYCiiCy4k
	 4e9Ld1Y+IQUsw==
Date: Wed, 31 May 2023 10:25:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, alan.adamson@oracle.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix the name of Zone Append for verbose logging
Message-ID: <ZHd1BlqvojsROvxX@kbusch-mbp.dhcp.thefacebook.com>
References: <20230531125454.676077-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531125454.676077-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_092549_543639_033D5BA2 
X-CRM114-Status: UNSURE (   8.21  )
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

