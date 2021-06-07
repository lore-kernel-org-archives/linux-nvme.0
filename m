Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A074C47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:58:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB3761003
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 16:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB3761003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hXh38/l0Cyx6Ez/eI5o+Gz41jPt4r6u05WXrda/sqQk=; b=FeQ86bwj8OpoTb
	/x1nVO/+w0SNr2mCppIHn+5bMJvX57Ol/eV/0TnlbPBT0Qf8BQ0QKmt3v7t76ynH+nY/BXGYirRjv
	Js+JMdlbXzVsxmuiVlhseQ/+AmTL+4pvhZVaybC0dGQ5NzNxXG5xn/ERyUv6nMh/n0CxWItgMYow1
	H4obDMCOjGAIis3eBt+wnh3RdFDYOO9gezPxPVdekALOYiN0jBq6VpaAxC8QyAp8uTupm43jVVLj0
	PAI+USYxJHxkiBvYCgoWM3eCsf8Fv3CjCPyPWliN6hLV1Colv0VedGViiga9GiLC0VN6MyB/rQ25W
	brdVz+aMdqzODTwFZ4Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqIaD-004eWs-D4; Mon, 07 Jun 2021 16:58:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqIaA-004eW6-W9
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 16:58:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B54DD60FEF;
 Mon,  7 Jun 2021 16:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623085114;
 bh=5yXe/by2vyZYp7WLgmqsGVz8qaFERIQWxmtpycVWR5I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tl5ttCz3+w2/RWHkD1NqmgzHqMHWOrkufh+qUvNlpD6bvFqYav31RSV7LykiF88gB
 iktaDpkCUtXcOjG2ImNmb9N/5EDGRy+2iQzt2bKngFUnjfQkLfm5FKLyscmL2QMgjR
 +v95Ba3H7JPoPvgBUb85kkh7djFkqrZmiVoCWqBva7471yIYGFF2K7EuB6nuPglZFy
 rPKNCAuSKBkuT77NefCflOGxnXeS5nbJN8j/IihZA6PyO8HPQEo5B4nmh+V55pghWh
 CW6ZPeHSJY8J79b/ilb2AMPYkbcUGnhRssKYPZoLwlHjrNlqFmxOi2SPc+GM2OC8RJ
 5U3pOFvvJAMmQ==
Date: Tue, 8 Jun 2021 01:58:27 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@kernel.dk,
 linux-block@vger.kernel.org, Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 4/4] nvme: use return value from blk_execute_rq()
Message-ID: <20210607165827.GC21631@redsun51.ssa.fujisawa.hgst.com>
References: <20210521202145.3674904-1-kbusch@kernel.org>
 <20210521202145.3674904-5-kbusch@kernel.org>
 <20210524080428.GA24488@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210524080428.GA24488@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_095835_083427_4848C1A0 
X-CRM114-Status: GOOD (  12.55  )
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

On Mon, May 24, 2021 at 10:04:28AM +0200, Christoph Hellwig wrote:
> > @@ -168,7 +167,8 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
> >  			nvmet_passthru_override_id_ns(req);
> >  			break;
> >  		}
> > -	}
> > +	} else if (status < 0)
> > +		status = NVME_SC_INTERNAL;
> 
> Don't we need a better translation here?

Did you have something in mind? I couldn't think of anything more
appropriate than the generic internal error. The errno's we get here are
-EINTR or -EIO. Both indicate we can't communicate with the back-end
device, but these problems are internal to the target from the host's
perspective.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
