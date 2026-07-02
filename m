Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15983C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 00:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g23Smlgv36tz/nRKQRwM2wZEV9ZS31aK9ItwDzqu71Y=; b=J4+FLjrG2D6afj3ehxWKtgXskr
	XNolnY/QqPAnL4eRic/tQyvTShnQpgju46esfwZuNEv4ZsTz7euJtr9N/z1jHsx3gQIvJHdXbZrRd
	bkZMT6OrTT0v4G8QO3eVf9sLDhUNJ1l1aeN1L9IC5F+aPf3CA6hJxHzSjX6/wuZaqJ8TEX9QOy6SH
	y8mwJ5vKykWXcJ2oC744uNC+n2wEYPuoeB76ndl6fqYJLdoB562S5TUgXGvaUF6SfgcrEOZsss5A1
	A8QvICk2fgKDTxdi3+kPQQi08w5txhP9pc5LZ3ONPmfeoCINDCbVcpmnm960syxJ/U8nRqpaV1YPq
	BVmcF4Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf5S4-00000003Ifa-0NOB;
	Thu, 02 Jul 2026 00:38:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf5S2-00000003IfE-20ER
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 00:38:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4120860125;
	Thu,  2 Jul 2026 00:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A691F00A3D;
	Thu,  2 Jul 2026 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952725;
	bh=g23Smlgv36tz/nRKQRwM2wZEV9ZS31aK9ItwDzqu71Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FLasALrAikS46IGhf1IHRhYiVYrlA1ThCPGZSHp3xCK6lTe2uimRj82mso70chRMW
	 yNDIr0FUaGMsC7OMVGfH7vcWDkjvoI1iHFubmiTCZzjhHo8vDA4OSehg1Wi5X3gEhj
	 Os/6BcciiNHpNtwbz+1cQ+K501BwkKuz8O7CxA3HuMlqUR25gjelR1z+LG1cwTlHUL
	 azAXWvRAoSn374/E9VkUiGZ82j9ihAVsPGxBa+8jLzcfFDSaJ+vBLV9K11G62L4q5j
	 fRDDzR/VlaOkc1x19nK1CYdqfnVSixsrGPK5V9IlEyN1JImQGIY/TrmX0N0049Bciw
	 Vd4K5fCcykGIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	skumar47@syr.edu,
	kumar.shivam43666@gmail.com,
	kbusch@kernel.org,
	dust.li@linux.alibaba.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philo Lu <lulie@linux.alibaba.com>
Subject: Re: [PATCH 6.6.y] nvmet-tcp: fix race between ICReq handling and queue teardown
Date: Wed,  1 Jul 2026 20:38:28 -0400
Message-ID: <stable-reply-nvmet-tcp-icreq-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701134933.66838-1-lulie@linux.alibaba.com>
References: <20260701134933.66838-1-lulie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> If io_work later processes that ICReq, nvmet_tcp_handle_icreq() can
> still overwrite the state back to NVMET_TCP_Q_LIVE. That defeats the
> DISCONNECTING-state guard in nvmet_tcp_schedule_release_queue() and
> allows a later socket state change to re-enter teardown and issue a
> second kref_put() on an already released queue.

Queued for 6.6.y, thanks.

One follow-up: 6.1.y, 5.15.y, and 5.10.y carry the same unlocked
"queue->state = NVMET_TCP_Q_LIVE" assignment and don't have this fix
either. The upstream Fixes tag (c46a6465bac2) doesn't correspond to a
real mainline commit; the race goes back to the original driver in
872d26a391da ("nvmet-tcp: add NVMe over TCP target driver", v5.0), so
all three older trees are affected. The mainline commit won't pick
cleanly there for the same NVMET_TCP_Q_FAILED reason you adapted for
6.6.

Would you be able to send backports for 6.1.y/5.15.y/5.10.y as well?
Your 6.6 adaptation looks like it should carry over with minimal
context changes.

-- 
Thanks,
Sasha

