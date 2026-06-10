Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2830CD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 06:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UAWeR7hUP3bLrsobOVF8T1MNmJV+xvCkerR0WtRSKIg=; b=BP5xnQoFQqAAjyRroETzZ6vddp
	13wg22We+TdRiDv1xWuwpVFwnXzpO7YodLx/frpTRvKJqh9uxnDtecG1AGSBG6nZRVuUWgxg1DyZb
	0qYXcunEmrooFAVbSUjP1qYLiM4ePdXR5z/DytcEyVcvac2pbHtK87bRwv8UlN0TYUtIo7VwG3gfO
	QZfKeXBU07MaNvdUXBM+4iocglLj9sH8Vm9AjyaxwE1T6nwsFHgAblgI+qplSdOnM3VNdpGeLW0Ag
	Ak2dNACGJi8cHRuk1cSnYJPKnZt2HTI5RNO7icCicqI//QzZAsTNkhKxXy+txySfjfUKweuKL2LrT
	mKsS7qJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXCFv-00000006rrA-1xLd;
	Wed, 10 Jun 2026 06:17:39 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXCFt-00000006rqN-2BZi;
	Wed, 10 Jun 2026 06:17:37 +0000
Date: Tue, 9 Jun 2026 23:17:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Yuzhuo Jing <yuzhuo@google.com>, Leo Yan <leo.yan@arm.com>,
	German Gomez <german.gomez@arm.com>,
	Anubhav Shelat <ashelat@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 1/3] perf build: Add libnvme feature detection
Message-ID: <aikBgfn9yZG93sZQ@infradead.org>
References: <20260609070348.541964-1-irogers@google.com>
 <20260609070348.541964-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609070348.541964-2-irogers@google.com>
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

On Tue, Jun 09, 2026 at 12:03:46AM -0700, Ian Rogers wrote:
> CONV=ca4c5d09-4ef8-405a-80bb-aa988020b436
> TAG=agy

What is this supposed to mean?


