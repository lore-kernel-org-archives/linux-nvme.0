Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731BBC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jan 2022 19:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qcTWtImjSv/IKa8U1ZDMasjCJ9CJxcj4OoduIWlDcq4=; b=cQzljNmOE+gGnfdS4rla/+8vlb
	GkyD+kv8ZTuMmVNQ8kEv3g16skFL0OdGcEgfu0vSH5O3MdLM7k3WhufLK1FH38Ipe0WpCIdyi2zFS
	qnUojYu746UDeHbvu4d+/hH0Fx1bG2ggpeHv42dIJBrCBDL6k7lNvqh5YkOMG+zF1N8sGLbRm6MMn
	t9KF+l+c82NB57AA4q60S8bkXfgH9xtZokxXetIClSN2E+AnjiyshDIu2AnI7K3nfRkBdPYkmq1fX
	8k7db9Tpq+3nEA8Z/LAZv6XAFqarvDm23qhjih6ERTZCVFr0QkugPaG8CRzuswSm0SpMEgNTEfho0
	01tYriUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nAz9l-00Fudl-Hk; Fri, 21 Jan 2022 19:01:05 +0000
Received: from mail-qt1-f181.google.com ([209.85.160.181])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nAz9i-00Fucl-AU
 for linux-nvme@lists.infradead.org; Fri, 21 Jan 2022 19:01:03 +0000
Received: by mail-qt1-f181.google.com with SMTP id d4so10998727qtw.1
 for <linux-nvme@lists.infradead.org>; Fri, 21 Jan 2022 11:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=qcTWtImjSv/IKa8U1ZDMasjCJ9CJxcj4OoduIWlDcq4=;
 b=peS8+aF3H/6m31CW2FElBzXIqHGcA9qDrqY7b0GxSFbz1lgb0Hz+kN/gleWcVw6DOu
 17pWkGvex7XWOkRxs1a+iD6j9y5tmMGaJPXAyVMWpq3WjMfD93bHshyd/bmaLFXCwsOM
 Y13+pyfFe8SaOuUNWPPTFqaw6UqFP+MnBkq8ZlnY/wXoYQuY93546R6OAY4nQzM7BEqr
 kKMF8sm5/5w4ot/8VeP7tW+Yx56TwqDilNbGT8q/McNgIMGeXMNOz5o53b4dED7bv8NX
 mOILqwqvw/XEklQJllj+IaIPhOv0CYdeMpt4SmBEAJ5FQG0EsN6YXnczldsDJ8pAIbxW
 sSQg==
X-Gm-Message-State: AOAM533jV0BuaQF8IyYkfTTj8fFUvY6b9zUbiPXvEzTnBqJB/Z/z+xE1
 vvJsTjBEP2mYCIU5UqrwEAiM4uzkRfHBkUIYkfc=
X-Google-Smtp-Source: ABdhPJyuCR+SmirJdSiW2AywJ+r5kBb0SMVoSkmDQY+lIDivISAXiLXa1FRk8dJkdQNCEpV3MKOA4Ik2GJyMfvyLmAk=
X-Received: by 2002:a05:622a:293:: with SMTP id
 z19mr4389219qtw.302.1642791660062; 
 Fri, 21 Jan 2022 11:01:00 -0800 (PST)
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Jan 2022 20:00:49 +0100
Message-ID: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
Subject: [Bug] nvme blocks PC10 since v5.15 - bisected
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 m.heingbecker@googlemail.com, linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220121_110102_387167_6C77A8A6 
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

Hi Keith,

It is reported that the following commit

commit e5ad96f388b765fe6b52f64f37e910c0ba4f3de7
Author: Keith Busch <kbusch@kernel.org>
Date:   Tue Jul 27 09:40:44 2021 -0700

   nvme-pci: disable hmb on idle suspend

   An idle suspend may or may not disable host memory access from devices
   placed in low power mode. Either way, it should always be safe to
   disable the host memory buffer prior to entering the low power mode, and
   this should also always be faster than a full device shutdown.

   Signed-off-by: Keith Busch <kbusch@kernel.org>
   Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
   Signed-off-by: Christoph Hellwig <hch@lst.de>

is the source of a serious power regression occurring since 5.15
(please see https://bugzilla.kernel.org/show_bug.cgi?id=215467).

After this commit, the SoC on the affected system cannot enter
C-states deeper than PC2 while suspended to idle which basically
defeats the purpose of suspending.

What may be happening is that nvme_disable_prepare_reset() that is not
called any more in the ndev->nr_host_mem_descs case somehow causes the
LTR of the device to change to "no requirement" which allows deeper
C-states to be entered.

Can you have a look at this, please?

Cheers,
Rafael

