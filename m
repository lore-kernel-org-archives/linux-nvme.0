Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297B2FD9E19
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 22:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R8oMuuApxDdobSx45DH3pCMMaoyXB1fUEi9zXbudQqo=; b=ddwhCTyEmUg1XzLCZV48yVGBI4
	M+QS4xKhN6QlXCst8eaVA/ZeGM7gGFbkSVz1lZfe7uu61v4s1YpL35kuT/7Gh6p1ROTd/gzIJTpYb
	cRUWBaOPcav6gPcfk41lCYqAm9aX8RhHiJh9A/odLTXv0JYlhlxa/HwSRvSqSShGRul/9rj7lEpiY
	/vo86s7z6HQipUnJVg0zMN8+mU3B90BPyp2PxYCrcXDjIhAISOgiFmz+xsPsX6ngHGt38PpP0UOTd
	mJpaAx9jxOeXwMCTevuYcn6pvUJvbeDCJeTosdXRTnFAaenTAg9oQocQudH0GYgKkQg6frfuaHUuF
	vkbOuxCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvjy3-00000007JkD-3x1B;
	Thu, 26 Feb 2026 22:36:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvjy2-00000007Jjs-24dQ
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 22:36:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 711E440214;
	Thu, 26 Feb 2026 22:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BA5C116C6;
	Thu, 26 Feb 2026 22:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772145380;
	bh=8jDnLh5O/aN11ZZCA8h14oHZW9pDxmLNI6HyNiqO/C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CG4TyfBQmRRedBWwTzOb21f9Llm2JwQLHDabsRVAB8nzITUTixV56TpHyxku4fjnh
	 hZZOc1rePGwbxmLtcLmVbeDSIuaqfGt7GPwM/vHpdIqyq4alinMUCnO6lCSlu3r8Jq
	 3grR8pp4CBAfqEBjynKzd4RYokjOIra2wrBak5ujcG11rlj9mvAB4LVq4Hw+840aFp
	 VOkx+c85ekfbs2IT4rNgwOZsQ2T+f/Zt5ab9R3RKmmiKkSuIyabqAJhuw1fTpcP5Sn
	 zJwBsj5MrMPOClLDUIHMG/sFTOZ4m8910WGpWGS2geRw2pPKoYz5IvUkDtNBDtmWrC
	 nJlLarGgScjJQ==
Date: Thu, 26 Feb 2026 15:36:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: Justin Tee <justintee8345@gmail.com>
Cc: linux-nvme@lists.infradead.org, Aristeu Rozanski <aris@redhat.com>,
	Daniel Wagner <wagi@kernel.org>,
	"Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH 1/1] nvmet-fcloop: Check remoteport port_state before
 calling done callback
Message-ID: <aaDK4lB7Xw-dhqa0@kbusch-mbp>
References: <20251204202613.14908-1-justintee8345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204202613.14908-1-justintee8345@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_143622_553520_A47C0197 
X-CRM114-Status: UNSURE (   8.83  )
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

On Thu, Dec 04, 2025 at 12:26:13PM -0800, Justin Tee wrote:
> In nvme_fc_handle_ls_rqst_work, the lsrsp->done callback is only set when
> remoteport->port_state is FC_OBJSTATE_ONLINE.  Otherwise, the
> nvme_fc_xmt_ls_rsp's LLDD call to lport->ops->xmt_ls_rsp is expected to
> fail and the nvme-fc transport layer itself will directly call
> nvme_fc_xmt_ls_rsp_free instead of relying on LLDD's done callback to free
> the lsrsp resources.
> 
> Update the fcloop_t2h_xmt_ls_rsp routine to check remoteport->port_state.
> If online, then lsrsp->done callback will free the lsrsp.  Else, return
> -ENODEV to signal the nvme-fc transport to handle freeing lsrsp.

Thanks, queued up for nvme-7.0.

