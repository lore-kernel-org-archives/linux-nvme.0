Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B363109C055
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2026 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+GA4/9xtXkKrksVBbHSHcgOuftKgItmsz7MH3HGa4+8=; b=v6e/ClKixM2aH/R5oCDIlEobKc
	PVBIpTtGIIg9gMYIwvvl1WDrkHrf+Kuf+yMnJv0kyCZqB2Kjfsyewlr9pQXz1xCSwIZnrOr6NZd7w
	R9oFF5MTqwSy8GmxxbGqb2pSy8Hm2hagEhuob0TcpQ6/5vE8epSFZ4yvxLk49Hsd7bIimqQpNwMPW
	05tDFCXtpJNmNKYvZ2d2wRE39PgYOByfWAw71DiK3YD4Z9JO8JSoKW11yZ3hJ2jJIO0Pmbf3OXvqB
	8BR++cpRQtv0dqYJVTcaG059oWHiaYCoFVIVsAEXcgO9pIzc8QGlFz2o9sdY3aidmARZXw638Gb2h
	w2/wZbJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5T7f-000000045YM-1sdn;
	Wed, 25 Mar 2026 18:38:31 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5T7b-000000045Wv-45Bi
	for linux-nvme@lists.infradead.org;
	Wed, 25 Mar 2026 18:38:29 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-89c6a711ce9so1881916d6.0
        for <linux-nvme@lists.infradead.org>; Wed, 25 Mar 2026 11:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774463907; cv=none;
        d=google.com; s=arc-20240605;
        b=h2WqViPZEPlsYQOx89ZQMM0EMPhDQ/dMyjriFRMVEkKt5cjfdbxoFVZgq+FWunyZMJ
         91Ib6KRqWOkKkasUKePGFCcfUaGvRIfoXCD3cmJc4OZ40X+ZBNoJj4APFnYf+3eCFSLA
         MqCifW52xPoiPwuFeF6D61Dcu/gNvTLoXCUSUK4KIgsnzVJrmOOIo4lhR+cu/gj7MmC4
         vgY+M4ij017JYOUppYE1cvmfQCghYqDsMCtZRp3yvQgOyDzS5SHpaNHkbMkAxnnI5EGA
         1imseTsiZA6v5CGbu1yf5winqBtg1zqh7P7HRi+UtQM/P9J8eoi2Zo1YqMfh28VWTng5
         PdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+GA4/9xtXkKrksVBbHSHcgOuftKgItmsz7MH3HGa4+8=;
        fh=bcXitY8bnqRr9bnNe3uLEGFk9lsGXBQgSnHja8g+RSg=;
        b=RH6povkOypYKVsPLHbVZZNlLpgBkqpRT76PqWjbx7FqWlFGdDSuA4zoFh/C61t1UYC
         MnSK2k5vfeIYUSF9Sqc+YMN0oscAhXla7izoJ7OX9s5UGzPGS1MFAYB0LR+/6XzjLdtY
         SPb10QOKC4yWmC+KDbJR7TyQxkpMyy6jjNKTJZiqNQ4HrsuleslmDWT1/Gbw/CbjeGlx
         luX7b+NAuswsyI3tJ7uCteTZFOahVj+y+r7eUahkzA05mfc5QA3DmLIeJN51R746uKDb
         yBohs+fJemijAfBI7CqhUIejtRoazK6ZC31sp4lzL0SioMDSTN3AoNf7a2rbPPqA0H5X
         6xoA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774463906; x=1775068706; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+GA4/9xtXkKrksVBbHSHcgOuftKgItmsz7MH3HGa4+8=;
        b=Zykpzcx5wvBJHymDoomGAEKhe3rGmm0yZLgNwqDmKp/J0kT+BtClsriCNuo8BWkEP9
         55FO8tFQwEyPB4Vmp6gaBuN3rBZKQDZDnlMVJYt1kXNLsWuPFseK0JlUDLvuEi9S/f1U
         mGXDTd/2gb6JLytMjCJqZUo0RzfO7ah5GAG6tBmmCbD+9jS5sL1NyNdcbWhC2p3QU4cF
         +/55eA4gVnPsLgmawyC0mEA4TDsWz4QA3bgriYK8CWiS2RQO9QAEcgGx96hZK7gjIROP
         bb9fqqZq5tBBsOM87H6Ge1KPXcR5wGEiJvehRlYnL4Eoo7YB0+RIdT31HCzCPFYX29Sp
         ZMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774463907; x=1775068707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GA4/9xtXkKrksVBbHSHcgOuftKgItmsz7MH3HGa4+8=;
        b=AYGgdsGI24RwTlucJ3iYuZPWed4oGIgkA+B3nYOIiYMXRuLSFlz1zjDk1os3pycEEE
         OAPICkLhFSQT8MeIYvo/P8UpPwCcBhfVewgpE8MpGm5DLlYQKU85D1rlmlTUOPY/mf5g
         KzSZz7XVP5Gjqo+jWgxVz+5EOsxl0spkL+4WPAflV1agf3PLqTObk4jmhlpxOFQbzk4R
         bJI4S4Reb89oaNTopRSfeDRrctZccXe6xZ3H5TeZwP5zz46ANfzpi+dtU73JgFzW2a9t
         IQS5qZlOn7FJvvASgBaTaIyQJMacZK9eSgo2BTLH5nY4DUh/DMJzMwBPqWHyJTQbF+U7
         0S0w==
X-Forwarded-Encrypted: i=1; AJvYcCVrw4pjM8Qiu9JDJDj9+FB2hS6TKKFgywwVGQ4K8OtpO3qeXMvfHD2xPNs2IfvubE37JVb4PfwHwLx8@lists.infradead.org
X-Gm-Message-State: AOJu0YzzD12s9jcjG9GhmS5VR0GFcwsgEtFPN1WZc03jtGy92kMzbMuz
	vWBbjqhFHHV38xg3QwdnOSvdhTs+Hd42X4WgVLeaxxdT9UH79pO1/axIDQwODh2evtlc0sx0vpJ
	wfq59wWA/lB5g/s8DgoB7t7SMnmiidtY=
X-Gm-Gg: ATEYQzxlg9zWGnQSWhFkWhsAKbSMoAlj1T/CpNQBoh0ix/GejdQLHJnJ7FFdBHURRtn
	ZxwLqucdeZ1YFTmuFbfa4RELq48jkLT07wUI21K9Hqwm/vIDYpRFU2TxGnOntdOo1c9b9Ccz3/z
	BVYwlrrbjyoICciJbO3PMuC/eO59JkxkgjFEYIee84OEglIj3vPQYSFHjB/H5zsnS7QTqTlzyBm
	CpglXCf/JoClu5GVGQz+fYGKNUOVW98gUumTApVht5Uj2x0cCLO9dgeUHgyInUAqyyEqydCLkCq
	7vGfGVVRI7cBIK47AEOXRqZBCjSsKRmYgS/ZPqAo
X-Received: by 2002:a05:6214:f07:b0:89c:d7f5:b9c2 with SMTP id
 6a1803df08f44-89cd7f5bc2fmr605676d6.31.1774463906525; Wed, 25 Mar 2026
 11:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4>
 <CGME20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p6>
 <945a3e98-ee75-453c-ae80-f3c9e3e57e58@gmail.com> <20260325063333epcms2p60954532c1b65a1665bad6dcdcfd7d62c@epcms2p6>
In-Reply-To: <20260325063333epcms2p60954532c1b65a1665bad6dcdcfd7d62c@epcms2p6>
From: Justin Tee <justintee8345@gmail.com>
Date: Wed, 25 Mar 2026 11:37:44 -0700
X-Gm-Features: AQROBzAKxPhpmC6ZawP0BlTH0WgQy62IbCN9C0mYIPU9DegmKkKMWApqZpayBrI
Message-ID: <CABPRKS8-x6Tfr90inpz1fR0=8a5HD=mkujtfLJ1h9ikEUjTvxg@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: Add nvme_setup_cmd to host_path_error
To: hmi.jeon@samsung.com
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"sven@kernel.org" <sven@kernel.org>, "j@jannau.net" <j@jannau.net>, "neal@gompa.dev" <neal@gompa.dev>, 
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, 
	"justin.tee@broadcom.com" <justin.tee@broadcom.com>, 
	"nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>, 
	"paul.ely@broadcom.com" <paul.ely@broadcom.com>, James Smart <james.smart@broadcom.com>, 
	"kch@nvidia.com" <kch@nvidia.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_113828_017854_7461D420 
X-CRM114-Status: GOOD (  11.97  )
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

Hi Minsik,

> - After
> nvme_setup_cmd: \
> nvme0: qid=0, cmdid=32777, nsid=0, flags=0x0, meta=0x0, \
> cmd=(nvme_admin_identify cns=1, ctrlid=0)
> nvme_complete_rq: \
> nvme0: qid=0, cmdid=32777, res=0x0, retries=0, flags=0x2, status=0x370

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 766e9cc4ffca..378d28b2c971 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -512,6 +512,7 @@ EXPORT_SYMBOL_GPL(nvme_complete_batch_req);
> blk_status_t nvme_host_path_error(struct request *req)
> {
>         nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
> +       nvme_setup_cmd(req->q->queuedata, req);
>         blk_mq_set_request_complete(req);
>         nvme_complete_rq(req);
>         return BLK_STS_OK;

Since trace_nvme_complete_rq is printing only cmdid to help identify
the command, why not define a new TRACE_EVENT(nvme_host_path_error,
...) in trace.h instead?

So, perhaps something like this?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5037444687bd..a2e253dbb744 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -511,7 +511,11 @@ EXPORT_SYMBOL_GPL(nvme_complete_batch_req);
  */
 blk_status_t nvme_host_path_error(struct request *req)
 {
+       struct nvme_command *cmd = nvme_req(req)->cmd;
+
        nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
+       cmd->common.command_id = nvme_cid(req);
+       trace_nvme_host_path_error(req, cmd);
        blk_mq_set_request_complete(req);
        nvme_complete_rq(req);
        return BLK_STS_OK;

Regards,
Justin

