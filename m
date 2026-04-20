Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A10F588E3
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PMKYTHQDFeOIzfmZciO7+PsYdo60yhX6bUTp+KObOLE=; b=XvBoNiZDscHIjCOTle7Kc0g3sH
	dusCo2GnR6dr7cOIOTI3E6LfAK+F7P0H9AUC/1BLvRCxlD33PFom37nfdIeACRJrkceWDAcVqG7uY
	O4bdibAISMfMAiTAjgA6I+gAlrLz+vqwVuKCBKfpXrSZLhJsQMHD77XhIR6pKrtk2nd7m2GnKPgCm
	77wBXufNYAwXrq8mUZjdHf1vt/M1KzxNVTk0+E8Rkd+LF387QQOS4LjwlPyL7PyYOr9HoJ8O8lZL2
	TC17lGUe5tTvG8F0Cd6ETX8gpeYrWQD6Xq1PG+aJd+kcAVtX+wZAs29HetOBAdzpm1TbFcFVl7ILN
	iu79dKEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wErXK-00000007R3T-0Lw0;
	Mon, 20 Apr 2026 16:31:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wErXI-00000007R3B-01KM
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 16:31:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7572440874;
	Mon, 20 Apr 2026 16:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3490C19425;
	Mon, 20 Apr 2026 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776702707;
	bh=VBsLVBVRE4nyBy3Wpg8Yd3gtZ2HMfPTicIZv9PaDDDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGA6Tz8l+Efaeu3PJg1QUD1kEyP0pskaKjsXfZorH4bGmAxJLIH2zOKijqblg1TOL
	 DX86YeoXeVAAuno1xtCUa+hX6mwgJ+YVXKzw0m9BcIKPt1pyTg41o/wqAk/8Ie9JoK
	 Hvwq/erp3kL7EXCLegrh0GvCoIGmAkqC/fU//EjPBD0F4ol5DyfFekQp36qxEEi7km
	 UzhKrXyHFacoQ02m7UBI2CLAbmwpDH6haTfHAK21UsRYZUiWoHBI4thDNn3gZaiVal
	 szvFW4sWzg2IJwTZDQ6IL57acIcsaEWg1WRtHHNj6mtpWYqojQLa2zGIhxypWS4Bxl
	 +eWSrF/VPp7Hg==
Date: Mon, 20 Apr 2026 10:31:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: alistair23@gmail.com
Cc: hare@suse.de, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH v3] nvme-auth: Include SC_C in RVAL controller hash
Message-ID: <aeZU8Y8oand_YYuf@kbusch-mbp>
References: <20260417005048.2898121-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417005048.2898121-1-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_093148_079255_4F49CB0E 
X-CRM114-Status: UNSURE (   8.67  )
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

On Fri, Apr 17, 2026 at 10:50:48AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
> included in the Response Value (RVAL) hash and SC_C should be included.
> Currently we are hardcoding 0 instead of using the correct SC_C value.
> 
> Update the host and target code to use the SC_C when calculating the
> RVAL instead of using 0.

Thanks, applied to nvme-7.1.

