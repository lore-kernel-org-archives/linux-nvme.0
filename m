Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD2BC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 19:32:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD8022D6E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 19:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD8022D6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D2mBlCY7b/BfltDKE4HSj4uO5pjD2+Rp/f+TP0myDA4=; b=C8i8k3kEkAWfYUTdWVskLLmXQ
	6WjAxtW6ssalu9GkC+N8rrrXasEyx+wP4/noGdoWsvVQ7d9OA+9GL6v3RHK/BeKa3fTgyS0c+drt6
	LRkKoY2njHbNMPY4Nq3xliPj7Vr9ItTUqcFfG5CJvBfw+jewwRPSF+4IdTuc1O0bUt8Bkf+aO/Yvr
	BrYKNxhEnhkBGUyxgYikRZanm0TzT2ySDgQePFFUQ3uqgvL4xaRxJd+foEzznhOrAycjmAO8KUVSn
	rrhkhFcv7TpviObignhtIkst0wnBrdv/ltZasYrQussxr+eEoIgCYob3o6xSdo+j6s23iRMsTaGIO
	S3cvT71rw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kws3r-0008MG-39; Tue, 05 Jan 2021 19:32:07 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kws3n-0008Kv-Cy
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 19:32:04 +0000
Received: by mail-pf1-x431.google.com with SMTP id h10so312384pfo.9
 for <linux-nvme@lists.infradead.org>; Tue, 05 Jan 2021 11:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=63yBsUdAnnZDjRjjVnpeI0yOk7dIpYMSTjutMDUiV3w=;
 b=e60sTImT3YHStDq+q3kzqQGg8+BD5TzIf/q4qgJ1x5luMq1hVMM5Bo/ertE+q4RaVZ
 rwa4NPqffnYqbVJucPY/j97AYU7WbkWPaCvP9Nu94rOSbzUrEsoN5xwdhxKATS/M8Wg/
 nVvbnnf57y9Z9nxDpSbccx+8oeqfXUpPZMd5L39v/RpW2RbTfIzDgCYgkO2GjdVz2KrL
 4e5sykyhyaqV3wM8DViNAX+oCLE2Mun2KrTQir1LNR8xUrpuBQGXZS4Z4/K4/0tmjxAf
 5rJwe/iGGka/d+8kvgpBwRhj2vLo6SzBx4jVwN47XBgQ7+l9K7/jM+d7GnHC2VMQ9LII
 znWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=63yBsUdAnnZDjRjjVnpeI0yOk7dIpYMSTjutMDUiV3w=;
 b=eITbnGwaZNgeudp5lcRY9/7xRScQpCVJosKnrrCjeJ3uaosO+bVThg4iKXSiv6n8AF
 QfQjZawhnloSrNESo3ALjLj7mK1J0VdrVHVTWyLQgx8Rj3BdtIXDKa0a2hIg+53ktcTB
 TUX6qh6qCbMeVhRZcCxExkbfPQ1eWUWzxTQHS6wFj/IT8bZZEOO8a+5pyOEB88kkkYr1
 Bx8QEeloLxBRjcj3JNKYtLx16yv1QvvQWEKrPlEEzr5as3bVRY1mLOVh7ykHWEN+3MUE
 u8fCzhNTAIS9HJQCVxCpBED29bHkes94ZNUdBGCFijohTCnMj7PRlxCb4HD9CZki9tNa
 9+mA==
X-Gm-Message-State: AOAM533cYv/9T1KYntUjShZZgaThDao9ycyA+mXuVAFObB6iZb59qcsS
 pA67Zs9ShjPXkfbGxQ+ecw4=
X-Google-Smtp-Source: ABdhPJwvRgOVCeobsh750figvDUO6xvDyxpNN2UQy3xtmzvcDGvrus2hfQqHYndsDKwOUuJs1vRzig==
X-Received: by 2002:a63:3d8:: with SMTP id 207mr765742pgd.215.1609875121297;
 Tue, 05 Jan 2021 11:32:01 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id jz20sm30030pjb.4.2021.01.05.11.32.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Jan 2021 11:32:00 -0800 (PST)
Date: Wed, 6 Jan 2021 04:31:57 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Michal Krakowiak <michal.krakowiak@linux.intel.com>
Subject: Re: [PATCH] nvme: trace: parse format nvm command in detail
Message-ID: <20210105193157.GC4426@localhost.localdomain>
References: <20210104155343.GA26034@michal-desk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210104155343.GA26034@michal-desk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_143203_480856_4F23F1BB 
X-CRM114-Status: GOOD (  20.49  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Michal Krakowiak <michal.krakowiak@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

On 21-01-04 16:53:43, Michal Krakowiak wrote:
> FTrace does not parse NVMe commands consistently. There are commands
> that are being parsed in detail and commands for which the trace log
> contains only raw bytes of command dwords. Add detailed parsing of
> format nvm admin command to make the trace log more consistent and
> human-readable.
> 
> Signed-off-by: Michal Krakowiak <michal.krakowiak@intel.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>

Looks good to me unless driver decides to go to raw trace with
user-space application like blkparse according to Keith's opinion.

Actually Format command has several meaningful fields related
to LBA format and protection information slo so that I would be happy
for format command to be parsed for now.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks,

> ---
>  drivers/nvme/host/trace.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
> index 5c3cb6928f3c..e0400de713b5 100644
> --- a/drivers/nvme/host/trace.c
> +++ b/drivers/nvme/host/trace.c
> @@ -102,6 +102,23 @@ static const char *nvme_trace_get_lba_status(struct trace_seq *p,
>  	return ret;
>  }
> 
> +static const char *nvme_trace_admin_format_nvm(struct trace_seq *p, u8 *cdw10)
> +{
> +	const char *ret = trace_seq_buffer_ptr(p);
> +	u8 lbaf = cdw10[0] & 0xF;
> +	u8 mset = (cdw10[0] >> 4) & 0x1;
> +	u8 pi = (cdw10[0] >> 5) & 0x7;
> +	u8 pil = cdw10[1] & 0x1;
> +	u8 ses = (cdw10[1] >> 1) & 0x7;
> +
> +	trace_seq_printf(p, "lbaf=%u, mset=%u, pi=%u, pil=%u, ses=%u",
> +			lbaf, mset, pi, pil, ses);
> +
> +	trace_seq_putc(p, 0);
> +
> +	return ret;
> +}
> +
>  static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
>  {
>  	const char *ret = trace_seq_buffer_ptr(p);
> @@ -159,6 +176,8 @@ const char *nvme_trace_parse_admin_cmd(struct trace_seq *p,
>  		return nvme_trace_admin_get_features(p, cdw10);
>  	case nvme_admin_get_lba_status:
>  		return nvme_trace_get_lba_status(p, cdw10);
> +	case nvme_admin_format_nvm:
> +		return nvme_trace_admin_format_nvm(p, cdw10);
>  	default:
>  		return nvme_trace_common(p, cdw10);
>  	}
> --
> 2.20.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
