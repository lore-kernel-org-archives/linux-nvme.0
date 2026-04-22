Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D0CF94CC7
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 06:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lrkw6xQCyvGpJ17Hz7OQT8i8IUO/OnqB4H3NAop+OFU=; b=e6U7AIbtjux7N1ayoaORYPxlO5
	UZvYzSiqCuCPBcFk0UpkpxfVBNreof2nqkrp70+xCrVd8VpRmSor1syohTw1X9KZWf2IdgiuiRMpw
	+3m53c67xVwn/FzG+2hWjZRRyh3aNriUwypUkm3YBWd0xldMfXmU1IotMXt246H88s/nntfXetqpl
	QDukqVLe8g7Hpqi0fjLNghDpBbXVWTE4hrSJID5id5uDvjK6QP4j6FveMvNQ/eVPSEXqKbZ1usNZ5
	6SC3qiu9TFx3pv1ADFpS7rI69PGet3ZjH+MTsKY88Bkf3PcfDy0lSdy7CDTna3x2tKRJ76zBI7ib2
	ozN7fq4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFQdw-00000009dYN-2bep;
	Wed, 22 Apr 2026 06:01:00 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFQdv-00000009dYE-2xGn;
	Wed, 22 Apr 2026 06:00:59 +0000
Date: Tue, 21 Apr 2026 23:00:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: set NCC and NIC effects for NS mgmt and attach
Message-ID: <aehkG9i9yisZgRR0@infradead.org>
References: <20260418130604.23441-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418130604.23441-1-ikegami.t@gmail.com>
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

On Sat, Apr 18, 2026 at 10:05:59PM +0900, Tokunori Ikegami wrote:
> This is to make sure scan_work done for the commands.

The subject here looks mistleading and the commit message is way to
spare.


