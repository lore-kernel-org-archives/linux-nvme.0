Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D5CC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Feb 2022 11:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=16j8kA1fpifyl3RRXLioj9BqtIwKaIsLb8qc0ZXOmeE=; b=BX+DJGT0+EyVgWTCy+jzx6MCgc
	/bgQ9OqFcAXdJP67IUkJ3Gs3pomg+Z91YUvq9XhwWNhH+oCKCJBxBI5Uwy8RXN8PhuDDMw+8ftOxO
	C58Ktn8s7cwThXA8lvdaSf80EbfnjyUwoigfTpO1h+qVaa/fViTG6SNXPW05a7R5fFvdAvhSMmWXI
	cs850eg+LB2Lh26kkNBnhfKeuWkYIY71GNPvsxJTvDTCKPVZd03gltLiFNM/PLnPIiPqYSUozyYQL
	CFCWicDzTn5uNIW7b6z/1BhXQua9X+BuVtfxIAcRwgBBOONuiwZ70aOyhsWK3YQ/k4YPmeXjC98df
	2UqW6kaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIU7I-006svV-AD; Fri, 11 Feb 2022 11:29:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIU7F-006suk-2V
 for linux-nvme@lists.infradead.org; Fri, 11 Feb 2022 11:29:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7CB53618F8;
 Fri, 11 Feb 2022 11:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE34C340E9;
 Fri, 11 Feb 2022 11:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1644578967;
 bh=gjtiXdPMflT2FKkDJ9SNKjbTlX4vf8jg3WINRVHAhAA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OLrMUDyPYQRe4is/ixcCvuJfnfXS8edGuL9lNVORcLjguadMhtRCn6mlobRM7Kmac
 FJoGUl9wRurv3mJuKSUQ3POZxLYT2vX/6pZ5Eb1pVJdA6912cEjWODr/MBcypk6G4K
 4Fthy2nhZeWnKjIFW2905sXrHeKUB7MrGbpBBNI8=
Date: Fri, 11 Feb 2022 12:29:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: stable@vger.kernel.org, Prabhath Sajeepa <psajeepa@purestorage.com>,
 linux-nvme@lists.infradead.org, Sasha Levin <sashal@kernel.org>
Subject: Re: Apply "nvme: Fix parsing of ANA log page" to 5.4
Message-ID: <YgZIlVkguNSY/a5u@kroah.com>
References: <20220210001721.GA151884@dev-ushankar.dev.purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210001721.GA151884@dev-ushankar.dev.purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220211_032929_186973_919C005D 
X-CRM114-Status: GOOD (  19.58  )
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

On Wed, Feb 09, 2022 at 05:17:21PM -0700, Uday Shankar wrote:
> Hello,
> 
> Please apply the patch "nvme: Fix parsing of ANA log page" to 5.4.
> 
> The commit ID in Linus's tree is:
> 	64fab7290dc3561729bbc1e35895a517eb2e549e
> 
> The patch was originally submitted on the linux-nvme mailing list, but
> for reasons unknown to me it never landed on 5.4 - this thread indicates
> it should have been accepted for 5.4.
> https://lore.kernel.org/linux-nvme/1572303408-37913-1-git-send-email-psajeepa@purestorage.com/T/#u
> 
> Without the patch, we perform the check
> 	WARN_ON_ONCE(offset > ctrl->ana_log_size - sizeof(*desc))
> at the end of the enclosing loop. This check only makes sense if we are
> about to read another nvme_ana_group_desc from the ana_log_buf, but
> that's not the case at the end of the last iteration of the loop. In the
> last iteration, the warning fires and the function nvme_parse_ana_log
> fails. When nvme native multipath is enabled, this translates into
> failure to establish a connection to the controller.
> 
> The patch fixes the issue by moving the above check to a correct
> position within the loop body.

Now queued up,t hanks.

greg k-h

