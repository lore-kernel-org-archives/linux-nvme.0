Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831C0C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:46:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC5B20781
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nMfqxmOx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWvb+6VE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC5B20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lmSnSpsW7y6aPfXxwzlz0cCJALaUtTA2jkzNUL5JQRY=; b=nMfqxmOx2F6pQP
	Dnqc36cEDdQ5a51MRO9swhGrESiQAVn9a0Bts6MVfcvezzmtqT4bv9c4oU1+8DvdqP6zj4lmQvAvS
	+Tjj4+xSTgyaUUC5cv96WMbL8q9RHCNrahNjuqwW8kMSo2I674SMJlDitoZtAdNIQiEnbbo+wnZqE
	jIrvZRnGzQ7Vgy9CfC8aJdkVPvpz0VTqizg9pHoIDveHt2tPzCuq32Aw59TINECz9xVZYhlRx6dn+
	/nlxgPuLrw53eLhwyw/2b58ev0/3YEjIGReas1dThgv5uEpqtHIYloD6Wvxey+Q+94cu+aK8QAZbe
	karyKfb/0jyozQHZWV0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJJ6K-0005Yy-2a; Tue, 31 Mar 2020 15:46:52 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJJ5o-0004zZ-V8
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 15:46:24 +0000
Received: by mail-qt1-x829.google.com with SMTP id z12so18715504qtq.5
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=g8eJTubDOpnYx+MtqM441enT6egVrVa4bYoBdzCqVy0=;
 b=VWvb+6VE6Bc3z/zRovKdw8FPguqnvnIL0uwajhY5uXtucaCe7G5c85lThPb8hTYhn9
 PHL8UjRnU/deAljnmmbMJgW8hSM1swVCyNW2OW6VVgfDQlYLeOzIN1ms85bXnrPLVjfp
 gURscr2MPffBwbRimGGc39gyNwgkkPSUHcXIpF981uDN/xVlURsl2L+jZJHEP9Q6N2/U
 0RmjKDv3e33dDDCV6KBvznLJ9FFRCF2gp7g8UX6Ot84jVjOCu1VjPLF4rq4xCRpxW6/m
 xc+sGYdo5GiXmo7cVGmvFQ5PPwcti5+DYPEvSt181iW17IaYwwGdANqpdxCjzS8sEHn/
 kPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=g8eJTubDOpnYx+MtqM441enT6egVrVa4bYoBdzCqVy0=;
 b=osDiRa+L1o/3ZxximQneMqHMYnJxDdci2OiOFsRw2lUVym7PesOCJ6SzOPU6bm1NIE
 h7swpKURS5tczE28RXwM0uKPJc8BrZDCYkYOczHyf/wdg+Ngolb2Oe6liA4qxzKrdPiu
 oFPBuYq7rYl8/Ryy4zqA88sYw9wle7bGd6NW3rbRmu+Sn4CHLkFrZxCw4g44iC94ws6Q
 au6UrN6sv5ieGywM3gfsLLARieR9AdHkGCaZ6lmh6w39b/tCKYQCIpxY9xZKzd2eLLqy
 QMm30dZkktXB5fgOLCEf31tCseXWD4kZZuF9aJa8kg4sb6tNxwOVJzGYhr8S8SwWfpAd
 ftQA==
X-Gm-Message-State: ANhLgQ3ibcDO/0etClie3bYgHcHCmPzA6y8LI1+QNyIMichrlfd+bBhc
 1zDcZI0L3KbQal7tC/P8yisLGGW7ppU=
X-Google-Smtp-Source: ADFU+vuHaX3R0Rod/OfU4HzywP3xMCDKTEorvnNns5X0xjYEKqcjXzXOibbmborAYzSd8CwlUgvZ7g==
X-Received: by 2002:aed:3c10:: with SMTP id t16mr5340804qte.45.1585665397860; 
 Tue, 31 Mar 2020 07:36:37 -0700 (PDT)
Received: from localhost ([199.96.181.106])
 by smtp.gmail.com with ESMTPSA id 199sm12602372qkm.7.2020.03.31.07.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:36:37 -0700 (PDT)
Date: Tue, 31 Mar 2020 10:36:35 -0400
From: Tejun Heo <tj@kernel.org>
To: Weiping Zhang <zwp10758@gmail.com>
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and nvme
Message-ID: <20200331143635.GS162390@mtj.duckdns.org>
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
 <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
 <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
 <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_084621_048823_96E7BE92 
X-CRM114-Status: GOOD (  11.33  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
 cgroups@vger.kernel.org, Keith Busch <kbusch@kernel.org>, "Nadolski,
 Edmund" <edmund.nadolski@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello, Weiping.

On Tue, Mar 31, 2020 at 02:17:06PM +0800, Weiping Zhang wrote:
> Recently I do some cgroup io weight testing,
> https://github.com/dublio/iotrack/wiki/cgroup-io-weight-test
> I think a proper io weight policy
> should consider high weight cgroup's iops, latency and also take whole
> disk's throughput
> into account, that is to say, the policy should do more carfully trade
> off between cgroup's
> IO performance and whole disk's throughput. I know one policy cannot
> do all things perfectly,
> but from the test result nvme-wrr can work well.

That's w/o iocost QoS targets configured, right? iocost should be able to
achieve similar results as wrr with QoS configured.

> From the following test result, nvme-wrr work well for both cgroup's
> latency, iops, and whole
> disk's throughput.

As I wrote before, the issues I see with wrr are the followings.

* Hardware dependent. Some will work ok or even fantastic. Many others will do
  horribly.

* Lack of configuration granularity. We can't configure it granular enough to
  serve hierarchical configuration.

* Likely not a huge problem with the deep QD of nvmes but lack of queue depth
  control can lead to loss of latency control and thus loss of protection for
  low concurrency workloads when pitched against workloads which can saturate
  QD.

All that said, given the feature is available, I don't see any reason to not
allow to use it, but I don't think it fits the cgroup interface model given the
hardware dependency and coarse granularity. For these cases, I think the right
thing to do is using cgroups to provide tagging information - ie. build a
dedicated interface which takes cgroup fd or ino as the tag and associate
configurations that way. There already are other use cases which use cgroup this
way (e.g. perf).

Thanks.

-- 
tejun

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
