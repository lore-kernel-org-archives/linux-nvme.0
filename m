Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EDE606A336
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FBl6SjXp;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=UuLK8hfk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jFkZAo9Q6iSPI3rhASOoo7X9X3+PA65f8F8L+U1OsP4=; b=FBl6SjXpHnIgzz
	bGKtX9zrVtt+Beq2zRtycTilcvnpIREacnCCyoDSZgZaVMyxsvhPvk6RQU7ke4hRfBo7J21iRhtRY
	n6aBhoHjmelvsF6ZGRvnCsnDBUZ9FYii0GsygxqllCopvBHvtjGB7sQJoYgvl/aPn4COQaY48Xnnl
	okqzNd1aTsf8Kd3HZjnTOjPnqv8M90e8is6QyaEprnMEwwJjwJFxjAgN7VPK8FOFTDgFkMxmlCu6i
	F9tJ5f2vjtWk4fFGpm6cKTw8RmtMXlue8gZ0RccDG1DsRfDSO64dzPjZE8OYgZnCaqPfod0E3mk/k
	mIryyKYJwHQfnVwhEgLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVvZ-00000004dRE-1XSl;
	Wed, 04 Nov 2026 08:01:01 +0000
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVvW-00000004dOz-1HG1
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 08:00:59 +0000
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-353804b591eso757915eec.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 00:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1793779257; x=1794384057; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jFkZAo9Q6iSPI3rhASOoo7X9X3+PA65f8F8L+U1OsP4=;
        b=UuLK8hfkoqXAF8m/Y/YjTeMKsuzStHYBS88v2J/O0sEXjAjkYSJNHhpiUAGuXGl5vd
         i3k/LEFKmrZ4SMJj9Hca5OJeJ5FjMELOz/YKvDD9detj+XGmmqcSsNp152QUEzWeRk4T
         AdSE6CYTrSYgUl9YfeGk2WdjDzwXO+Q8hCKDmVPJDBvmypincj/5ZAzEREibAqtn7F3M
         VOfEFQszqRvY2MnqLahPxYni+qosaBhs2bblxaUvDPE0clK1ywyxe4kKGaZJjdq2SMXq
         Pj0uiM/C2ZFMKTxJaKNZeFtq75L2ZVH4M44S6a5TVOVLlAEY/XlxGADZW1XaPLkJJZnY
         RKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793779257; x=1794384057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jFkZAo9Q6iSPI3rhASOoo7X9X3+PA65f8F8L+U1OsP4=;
        b=N94ucMZbYSulJh/r9KBkKrKTrk5JtDHq9/C4KXVpHPYEbv4H+l0DCUZrhT2AVu99Yl
         BjBvVp6V7pbMvvuCzg5PurIUfEU3c9InVeg2DXoO7EJ97wcAmTKyHPBwkhWMDL5uqcxR
         k33cMs8KLP2ti/32qeUh7wllj8lM90iQzzfhK5kaFr1vqw45jBGbFJLNoSDdyfUnUgW1
         HFP3Gezr/300v5uHmHHskQzRj+dFlSVaJDQ//uAM2+3xTnqaaDt8meXX4j+APP4ypC92
         qF5uXarcgjbZ6vKIFVi76UT62wOZMKqLbxK5uhg4JTB0M44H+wdd9Fs0F2G1lCIVVDEs
         8cJA==
X-Forwarded-Encrypted: i=1; AKwUvBxA/SW8OEHw2zGff8tx/rhhrEaVDrwmoka89hteX3HWZeov8CyJ2jpeoHBzZ89V0iC3hHE9JMh7NbWY@lists.infradead.org
X-Gm-Message-State: APuU4Z9t/Zy5iTqt1szI27kCLB2/XQvVOVF8CZL7JSOjBFiF7noxYx34
	3sIegT9jYJtwd+42+rZsyYGGGz7oOOBiT3XlljeEAMPvp2A3sW/lQTygXq+EPGA7eZ8=
X-Gm-Gg: AYBFou0mhUjEbDKh6ZVWTB/c4fIrGrdDNyM1OBUgqzEpbOsH+Z2qsc13vxo6/fqxu47
	OQH+1TzZcrnZgoCuag6ugDBoBc5HYKaaeBuNSeyRkkq5D/r6apdLYSk03HMMbjUCh0vSMdTGDY8
	uJDIqZMlmvRwPEuELKoES+LWrfAUfdmqCSTbU3wZ0ZLham/S8gpsSWbvhl2FCIT9IR2hc3TCi3O
	Z+im7EzknhXKBOZUC3Pj+iJQwO/Ct6DCK1X/PZXSvg0TtdLbO60CVQ9hhz3fqrysl9B2zj9aMGF
	o1bJCBHyJUDsnP8WdjwdQwAqQpKSpdBO9jC1WRlGsEdTAzUeqf17KvlfVbw7uGioKT7Opdok1JS
	dIxFla7vI8cV99AxaXY1dbJ9YSpA8fiCp5FPmGz2wK0i4NRgsZXvzw32LtmYJgSDDn3t1aewBs+
	WfOoJ1Kn6pTFDl1DkZPZaMlQFhlUEE2Xi92movAZspyoMO+w1A+h4iFeKNk5SjV8UKvQiGPS/mk
	49jzkGxK33WnRYDBK3v6At7gb3HdOF3OCLiFVnoDo5d7DGCy9idXPU49/vhX3KReFJbqtgumJwI
	+DlCDY3BazZqMOM6+zrliwvC33VVE0nE99EVtFvY3/BnTKXJao1ibuh8jrqwav5p4Z+VJuKJbA=
	=
X-Received: by 2002:a05:701b:420e:10b0:14c:1f57:3e86 with SMTP id a92af1059eb24-1ac5e6f5fbemr23645043c88.47.1793779256879;
        Wed, 04 Nov 2026 00:00:56 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([71.202.170.54])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c772fdsm6175875c88.22.2026.11.04.00.00.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 00:00:56 -0800 (PST)
From: Saravanan D <saravanand@crusoe.ai>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	dwagner@suse.de,
	sgogte@purestorage.com,
	hare@kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai
Subject: Re: [PATCH v6 2/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Wed,  4 Nov 2026 00:00:26 -0800
Message-ID: <20261104080035.95142-2-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <4b3a601f-3035-4883-ad2d-c6a20d2891ef@linux.ibm.com>
References: <20261023230426.6425-1-saravanand@crusoe.ai> <20261023230426.6425-3-saravanand@crusoe.ai> <4b3a601f-3035-4883-ad2d-c6a20d2891ef@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_000058_353779_C9DBE4E2 
X-CRM114-Status: GOOD (  11.80  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 7:45 AM, Nilay Shroff wrote:
> I see here nvme_queue_dir_create() is invoked on every reconnect. Although
> it is guarded by ctrl->queues_kobj, the directory is controller-lifetime
> state, so it would be cleaner to create it once from nvme_add_ctrl().
>
> Moreover, this also makes the ownership asymmetric: nvme-tcp creates the
> queues directory, but nvme-core removes it from nvme_uninit_ctrl(). Could
> nvme-core manage both creation and destruction instead?
>
> One way to do that is to add queue_attr_groups to struct nvme_ctrl_ops.

Thanks for this suggestion. In v7 I will add queue_attr_groups to struct
nvme_ctrl_ops. For a transport that sets it, nvme_add_ctrl() will
create the queues directory after cdev_device_add(), and
nvme_uninit_ctrl() will remove it. With nvme-core owning the directory,
nvme_queue_dir_create() no longer needs to be exported, and
nvme_add_queue_info() will take the groups from ctrl->ops, so nvme-tcp
only adds and removes the per queue directories.

Thanks,
Saravanan D.

