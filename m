Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FA4C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 00:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qdlh4YNnDYW/FiIxb/9VcT8z5m320xDKpRTlU4s3f+k=; b=mhyhGoC5Q3heUVaFKkdoms+h3G
	rBA5bfyVCJsLRqU+tUgxRkW6A5yk5ZxObZT5kCGiBBsESA/uGjOijoLsNiH3WqLl41d7WDlpn5x/b
	wxUT+ppwxT0uLT00Lzm6gxcsO2WmHd6k6uFJ9HhTsegE+OgpAjLL1QyrQq2GwqZER6MXCSgg7PZNb
	JZHSPgV0WCjBqsRWEbS6v28U9zCKlhXwHoyWgfuZrZC94508YiCorWIkvY+72yp2q8cyxCtrUY+x2
	d21kgHO+b744paexFK1vNuV7yGUdoDGhf1XDm48FrVzeAfBDT4YyQLoh1zL6trGYLXcwHhlIYByEI
	Z5Z986HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHx9P-0026le-V8; Thu, 10 Feb 2022 00:17:32 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHx9M-0026lE-K4
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 00:17:30 +0000
Received: by mail-pj1-x102e.google.com with SMTP id
 c8-20020a17090a674800b001b91184b732so4385886pjm.5
 for <linux-nvme@lists.infradead.org>; Wed, 09 Feb 2022 16:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=qdlh4YNnDYW/FiIxb/9VcT8z5m320xDKpRTlU4s3f+k=;
 b=LdGl48fqcOtxXpnqCyX9GyFeRnAvw3/5LeghqJ3nz2yaanZaBhNdmoNKgqn8vR7MWI
 O6V72NpDV4X1H8IsDs8w2HHkGH5Trk185gBo5wdL5n+e0AKWUX/TPhOfrCLuDGxGYAJO
 bIU8xJvLCTXCwE24Lc6bQp3bdnvTZnAYhG/Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=qdlh4YNnDYW/FiIxb/9VcT8z5m320xDKpRTlU4s3f+k=;
 b=DS91kjW9USKRrcKFYmc0HVggbU89OTde3KYfMoLMxGts2rgtwvjqAa+5ZlL+yZSZjT
 cjD62JpIanvVs+i1ALmdeD/jmuh6itFy7Dq2cBDkUDD86aSuq+o00ufmmWZAKkh379MK
 OMNEy46PlCM/k9DEoASpOu3RFVL7X7W6KiEBAkP24acoGbIc17O3wkE25tAwxwT+eyns
 U0E/G9o9BuFeIOsBtFTVP1G1Xb6FX84U9rjH1Il4ZhI772LsaGlpAAwZLX2b6CgCfwIx
 rxw/rsyD99ISPhD8ywbr/2Q2uwugrfig9UV8jX1Xk5U0FMupNKWEU2vUW2wKV825U+jt
 LZLg==
X-Gm-Message-State: AOAM532731a4jLd+94es3d19dV1VnJ/3CQBIsP5+I/g8f+VV+vXuzfW0
 VBTfoMliJupoWnVlJs+5Yh3Xxza5owipqc1O
X-Google-Smtp-Source: ABdhPJy8ESqngEbyWO8n+jbFs5AtOjj7eR7XIZXcKtuKCQ8OtLZ7Dcg4rkaObLDuUge9XSMv5xy0kQ==
X-Received: by 2002:a17:902:f610:: with SMTP id
 n16mr4969250plg.35.1644452246975; 
 Wed, 09 Feb 2022 16:17:26 -0800 (PST)
Received: from dev-ushankar.dev.purestorage.com ([192.30.188.252])
 by smtp.gmail.com with ESMTPSA id j7sm19407503pfa.36.2022.02.09.16.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Feb 2022 16:17:26 -0800 (PST)
Date: Wed, 9 Feb 2022 17:17:21 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: stable@vger.kernel.org
Cc: Prabhath Sajeepa <psajeepa@purestorage.com>,
 linux-nvme@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Uday Shankar <ushankar@purestorage.com>
Subject: Apply "nvme: Fix parsing of ANA log page" to 5.4
Message-ID: <20220210001721.GA151884@dev-ushankar.dev.purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_161728_779571_8998E32A 
X-CRM114-Status: GOOD (  12.43  )
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

Hello,

Please apply the patch "nvme: Fix parsing of ANA log page" to 5.4.

The commit ID in Linus's tree is:
	64fab7290dc3561729bbc1e35895a517eb2e549e

The patch was originally submitted on the linux-nvme mailing list, but
for reasons unknown to me it never landed on 5.4 - this thread indicates
it should have been accepted for 5.4.
https://lore.kernel.org/linux-nvme/1572303408-37913-1-git-send-email-psajeepa@purestorage.com/T/#u

Without the patch, we perform the check
	WARN_ON_ONCE(offset > ctrl->ana_log_size - sizeof(*desc))
at the end of the enclosing loop. This check only makes sense if we are
about to read another nvme_ana_group_desc from the ana_log_buf, but
that's not the case at the end of the last iteration of the loop. In the
last iteration, the warning fires and the function nvme_parse_ana_log
fails. When nvme native multipath is enabled, this translates into
failure to establish a connection to the controller.

The patch fixes the issue by moving the above check to a correct
position within the loop body.

Thanks,
Uday Shankar

