Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3C7C9830D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 22:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R2AFbu6PkunSu3wRLU/rJSEJuyRo49aEee30ieQcmVQ=; b=hIjhePmw9CkNY+eowvXi1Sm0bn
	NTVZlM9KTp77hKj4ksEGg358zSUwUWVX2poSBPtps4KNOTP9rz6SNL/DbzncPL2HUlXJ0M33MO7zJ
	qTdW8yJIfPBrRllROeGc2WwNKC1zxzQIJ5SCbYaPL9nUkY7P6QnDXlJ9MS/5nE/MXzqCXX+99nLHf
	GcZqWwN5O58qdvIJYyf20di/qImami02blzKLVTR7DAky9CW7W/6IQrKQuMC+lXLaLdLXPReGu9Ua
	r7dxQV2EX0kmPZ0oE4PtKXZto97rvNa2QnW60nIZuVDLM/YCd3Sf1zG45no9aFv+P33PvGkbcJhUj
	D9ZsxOcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VuY-00000009gcg-2k9W;
	Wed, 23 Sep 2026 22:57:58 +0000
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9VuW-00000009gc6-17qE
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 22:57:57 +0000
Received: by mail-dy2-x10.google.com with SMTP id 5a478bee46e88-3346e75082eso718407eec.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2026 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1790204275; x=1790809075; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R2AFbu6PkunSu3wRLU/rJSEJuyRo49aEee30ieQcmVQ=;
        b=Pndb6Yqy0p2FL1sWbJfaQ+ksZ/c+eWRSgRTBRXd//u6Rio6vRE4Gl13MYGx7ICWKOE
         EsbXR+TDNqDbIr7fGSzZZakr6Gl9uost/ugfnMJsN7XILLRzO9WXMmCzvl/mBj963k4i
         dJZRCRzs8KTGc+gu5lCTbYwmx9E0/PlvRQcvV/rD+g2kMBuAEeOb8TWzvm3OPxlcvzsV
         h3cmvM14WO7SopFhsfkWvOLrfJjwPCZATWSeUWhWuCWeLkayMLbzK0517Y5PjWCOmYar
         BDrWqDzM5pCDqf+jNHIz3oiWMKLU6qD5IpGUC5uNZz0sxv3WyNoF17nvWlS1GdMD3cBE
         LfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790204275; x=1790809075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R2AFbu6PkunSu3wRLU/rJSEJuyRo49aEee30ieQcmVQ=;
        b=dnYZqNl1ylJ8jYdoJ/Kn3m9U560LFmA/fBtUAQSAEtag+JUuoE4i/dz3MQGSp1yXbs
         PYLopvyHowcwHZvl3nD8JsfINT1VTZx5Kbx4nlWNDw1PHlBVdLZJmWWo1fnPNkFTX1m6
         6R8g+DiZ1/ZWakCCkbm3IplkiQYZWSxZAv594OOLFQe7+M892/slZFT5BZkNcb6Vlvs2
         pDSCtLAvC5q6DTHwdtlatIuBHRzb0h2y7jh7NKPjZJCLbi4ar4A4AzO+9AScJAGLoMZO
         rUBYyLjiz0K+gRmZ4eDPkK3de1Po+ozX5dHJuMZL8jY/BJmBMui2VsTCGBqEWVRVcN/V
         J8lw==
X-Forwarded-Encrypted: i=1; AKwUvByzRWt4hjn18VMykDty9z7UuzI+sHJSbnEFx2EkwYxN+VZ7kThE/CzDE0RFuICl84bN0cYGSCND6IQ0@lists.infradead.org
X-Gm-Message-State: AFuF++mXlZfTJiwwE0YLlZVWZC1O8SLP/IWmtB9in6kwh/qq+DuMBJ3v
	7OV+ISnnbhLizf5naFws72JL77gvxwTfQMh3gR+SWlRRMS/j0um+X5R/VlX75yTvSUh6Pga98dI
	Me7ITx4k=
X-Gm-Gg: AYBFou0YYyiIWkZFxz6brO+IGehBnvhPcz660PstZBk9vTzuz0i2k5I+769yrnE6Lhr
	Mu9ey8V2tmJ2auzhETkCOu+Hf9CJY8cqYcfH3DnAQW7+GEplg55FSBcK5PwjTGMC+7GqnsQHpo1
	1I9+yZB0QierTDrjYzko16OSm/wS82Q3THYeudGZWH3b4XS4WROMny/b0NoX+fhig+V8lO0SF3E
	nwhQmSgm14QRgb0HLDTqxptGptcS9Q6aDgMSf46Sa9KSPvvSwbXZJtQAZMHDTsA+YRJgiu5IvdZ
	x2hrDPvadnGcG+3JDaT1G5S8rz+/5IPN83Y856l4nP45tDOrsZEiBcnDlNDxEVVZTLk5GQuc6Ll
	MNjoQ6JSv3IffdNWGWqB6MjFh2U5/Q44exD8SLgxi4qbl4Arjek0Aa7XfO5E068EEYvBPFaf5Pk
	3ZwwAiNhmKU3drHdNAAX00YVWONpPm+kpi4tvwEeTIGHOKfO3VLAPg0WlWzA79CKCjG+FQ8hrhQ
	MGHXtyQFhnYqh3yAY3c1e/fFt2lWesYyEA=
X-Received: by 2002:a05:7301:c00f:b0:33c:1424:e57c with SMTP id 5a478bee46e88-34000c38310mr496652eec.29.1790204275252;
        Wed, 23 Sep 2026 15:57:55 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([4.7.95.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fe502sm8281568eec.2.2026.09.23.15.57.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 15:57:54 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: kbusch@kernel.org
Cc: hare@suse.de,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com,
	sjpark@crusoe.ai,
	saravanand@crusoe.ai
Subject: Re: [PATCH v3] nvme-multipath: add fail_if_no_path sysfs attribute
Date: Wed, 23 Sep 2026 15:57:53 -0700
Message-ID: <20260923225753.49224-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <arRJLL4ki-sVQnHf@kbusch-mbp>
References: <20260923004959.88440-1-kiyer@crusoe.ai> <arRJLL4ki-sVQnHf@kbusch-mbp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_155756_343824_C7EAE661 
X-CRM114-Status: GOOD (  15.50  )
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

On 9/23/26 2:48 PM, Keith Busch wrote:
> I agree with Hannes that we shouldn't need a new flag for this. The
> current behavior is just broken in a few ways.
>
> We just need to restrict queue_if_no_path to only if there really are no
> paths so that we actually respect the failfast_tmo.
>
> And the ANA inaccessible and persistent-loss handling you introduced
> here should just be the default without requiring a flag. But I think
> you need to add a requeue_list kick in nvme_update_ns_ana_state() too in
> case the ANA transition leaves the namespace inaccessible.

Agreed those are real problems, but fixing them still leaves no way
to cover this case. Subsystems commonly expose many volumes as
namespaces behind the same controllers, and failfast is controller
scoped and time based: a timeout fails every namespace or none, and
the trigger here is an event, not a duration one can pick up front,
while sibling namespaces should keep queueing and ride out the
outage. delayed_removal_secs does not apply either: it only governs
the window after the last path is removed (here the controllers still
exist and keep reconnecting), and its expiry removes the head disk,
where this case needs the opposite, fail the parked I/O and keep the
device. fail_if_no_path stays the only namespace scoped way to
release parked I/O.

If the direction sounds right to you, I can send a two patch series:
the default fixes you describe first, the namespace scoped attribute
on top.

Thanks,
Krishna

