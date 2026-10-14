Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF2DCC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 11:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mfU5sQaIGa+Ipl8RzCjqbbGQxUibRyyrfdkFZLGRo10=; b=rpM/T0U86x9xRU5fmSz05G1i2P
	Kg0/XLUaOI2weHsXcipO5w5swbniWXkP8qWlzV6693kZziCVRu/c/VicgSRrLgBr4/sh/xkzGLTs5
	NbtBg1W/usSSsJgbzHvVMhzIUkMTWI+HntGV7GsFp7e/bs//NweCPTzyJI577fFZp98E5b50u9HG6
	f9OXqNPr/3vCA2LVhIZueOe6n9j6FJ5yoz1Da4BVEsrKq3V0Rzywf8ZUCmGDVQZO2agkxsX9u4bTV
	a3xNQUxm99XCh0VMzJvMVPsmCduNyKmSg+R/Jvl5DhAqKSJjUgUGsoa8K+98ePoTgsdMfZHaQ0PFN
	Tlxpnwhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwiY-0000000FGOU-04OS;
	Wed, 14 Oct 2026 11:00:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwiW-0000000FGOA-37Ff
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 11:00:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=mfU5sQaIGa+Ipl8RzCjqbbGQxUibRyyrfdkFZLGRo10=; b=f3FC2wzOo6ScirrZ2wSUqQozxb
	kOBXDXLK7NlmrckyBgarWh5vHWAFHD15B1IB+KXo8g97bTf8nBAOrrnCz40LsHbPzYBypmx+xAeyS
	6fmt5l8qu64SrKkItkv4hTll6Nr0cLEFPiQMpw+atnkEGOA2gQRFhTvWfc7LRPlxAtxQ9/OqtCiBz
	sXPCBOlkPysA9zgZRXKlwSUN3Xs+OoOmh1392vLxlO+FdQJrIoSJS1zC39VGTdXuNV2v9sboBrAyH
	pocjbGplYDbdwznVY7Mdp59VXIaBUupBPerxl2yICgMw0j5JnFgrADDp//4lDl7pPiLniHAfv8XPj
	cRMUMBTA==;
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGwiT-0000000GeqG-3dc3
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 11:00:15 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4a022fee0caso37066865e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975611; x=1792580411; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mfU5sQaIGa+Ipl8RzCjqbbGQxUibRyyrfdkFZLGRo10=;
        b=b8z6Evxpx5r0E5dzxAvKWRYuiMzRSoDBI45BLTtX5NZXQjluY6cLLgrPszlvkmzR45
         4rxxHZ8TFInRb5Ofak9qR9P7eocMKjmrpf0F5x1JoCYHp2ih7ubqB74afIJKQftY0OeA
         VA/T7afQtbnxWoiYxdqTaZpyXrtGIWKzHng9Pz2mLt8Bj/jonERiLyiCUXGl+5pXwSvp
         295SQc/A2V8vg8DTiU8MHHO0r5hctskddgktMB4bCM2zxvQTN1EsAfhXau29APuPmMYl
         a2VgGdelZRcE8KqWJDh69dacuKGGtkKHAaVweXbfHJI96FIxKXT4wsQJ8yQ21QeVpudW
         IOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975611; x=1792580411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mfU5sQaIGa+Ipl8RzCjqbbGQxUibRyyrfdkFZLGRo10=;
        b=RpTvtkzl5kqKWbOVoO91C6yeCeVGpOYc/tZsfhCnXFOic8AofQL54To6TkKBLFmEcr
         CAIHFwTGcZSmOFzGe5rVVdu2wwCMDk+AJ4/U9HkOXlzzK7yHYmO4RTMF1pcKlWBkif/2
         weoZ8iRXHEB6cCm3XCioLT2/zBuMUW4Ye0Rr2BUxn1027ainy5Ewe12aOIYitWFnpa3G
         eZ7C8ib2oUG16gc8GpH55MXxJzQ5+gI4JwUaxj6oV52qLwZw9mxlpQLG/UAAAnps+x/2
         +iVu7LrCEHT0nVegATy6l0x1jYwoGrIerye6BUXicNUzoY68en7BJhTrmAV9cTALDUUg
         ZGRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtlVBy4I2N6i/Dn/VQbNQrNHlbUGzI7hF+Vz4sALRENATPpVxs/fEkYxtbZWKf8VO/aviLdUZwkH9D@lists.infradead.org
X-Gm-Message-State: AFq9FYIma7XDm/VifQ94riYcguHOmy/0dkAtUxa9Gn3DzFm5GSv6n0qz
	pzrcKpoydVeL0TvlhxAL24vPAOrJTmFRsuT9Hs0xE3INvjALZMvs4LOB
X-Gm-Gg: AYBFou3U3YnTKxMVVoKEXKQ1M90Xq4S0pqIVaS80InEADKX6XoXPZXeVzWDTOFZAODZ
	UEyfuB4tixSIizG3Bd+7Mv6O5t1MBZWylPpPhpCnnIU8ht+hzceSt9oxNrfLJ3BMOImT5ZhyJvX
	ZOBLWIi1wR5T08F32mqxQHtOFcDlzZctj8u9l956yYe9cEh5aJZ7XWnE1VXiIH9np18vXwCHyTX
	ZKNV7zpIQpBCF8Rs5LjDgoH/ImsByVzzH5V1jfvkp3DvnG97XQkP6R/2WWnZtRNSsZQ7LhHYcxm
	yPkLUs1/epmDvMD+wRrhxIwlVK6uVbsLcFJgQN729lqcCNBIpZ8321OvlOJ8P48+3jTSxokt9Yu
	aTKxugwz415zxjI7F6pAfSuYSC6N77zTs8tVQNFj6g6vrjpMJN9GbDAAIYUy8RO86z163ZvRPDY
	ZczMu/Q3yF1Hb5T323hngcNpGAdWdktrXcHQGT8VwjRhhUV5D0DSOkinvrg6Qzdmw3kivkWBXgb
	rFmdA+WEmI7xPKrWmPJaXdKysiq6NZHpH0jzqB3dGhXU4V0IOvgKuy3
X-Received: by 2002:a05:600c:8718:b0:4a1:7259:349e with SMTP id 5b1f17b1804b1-4a18e4e0a33mr298140065e9.27.1791975609638;
        Wed, 14 Oct 2026 04:00:09 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18f3b43efsm518169825e9.1.2026.10.14.04.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:00:08 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] nvmet: zns: don't leak stale memory in zone management receive
Date: Wed, 14 Oct 2026 13:00:00 +0200
Message-ID: <20261014110001.95212-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013142554.GC14759@lst.de>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-3-parri.andrea@gmail.com> <20261013142554.GC14759@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_120014_008701_EC64B3C4 
X-CRM114-Status: GOOD (  14.02  )
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

On Tue, Oct 13, 2026 at 04:25:54PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 12, 2026 at 04:12:29PM +0200, Andrea Parri wrote:
> > Tested over the loop, tcp, rdma and fc transports with a zoned
> > null_blk namespace: before this patch, zone reports carried stale bytes
> > and a data length larger than NUMD was accepted; with it, reports are
> > fully initialized and such a length fails with Data SGL Length Invalid.
> 
> Can you wire up the reproduce in blktests?

Sure.  Following Documentation/process/security-bugs.rst I had only
offered the reproducers on request; since you'd like them in blktests,
I'll post them to linux-block shortly, unless you'd rather have them
off-list until the fixes are merged.  One test covers this patch, and
two more cover the fc and NUMD patches of this series.

Thanks for the review,
Andrea

