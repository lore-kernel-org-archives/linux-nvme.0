Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75397606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nLxbGHe+;
	dkim=pass (2048-bit key) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=JqxEGn+c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Ak06+rRtQsPupbgxyIs6n4VqFtz0XTJF75o2FEFeOXg=; b=nLxbGHe+3AMk0K
	sGzD35PsyhcPNa+6YIHT6BLSmv6g7YDZlGuOEz1InjZdnS8iEiJZID9isCqzUPm9cpvA0VJJLDZyP
	kzEzQ1mleO5tpGAQwhLaWSWhgoHUOe2jlPmd1c6U6y1pqH04DJMJBWziFummcz5cLybclx4tjuTjW
	LtjN2AdpqD/je9JmneSKCQn1ElOfg/QJTc3MH7hRc67PQuB+96M1L64X7EZZHT0nwkbGK6G4CcbDs
	Q4HezEazgGUb3cMUNh1/JolgfMPVQXviNS2evd5d5318sVqLc5Q6Fo+VTz7MRlcqJXy2/6VSxicPq
	Twbbz+x4ZkA7P4hKleaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVmqK-000000063oj-08WH;
	Tue, 24 Nov 2026 09:29:40 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVmqH-000000063o8-2VMQ
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 09:29:38 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-3282db206d3so2107845eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Nov 2026 01:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1795512576; x=1796117376; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ak06+rRtQsPupbgxyIs6n4VqFtz0XTJF75o2FEFeOXg=;
        b=JqxEGn+cxgmeT3gFWj7qbsyjPz+LmJXrSZDzLXRkoF49eu+OEMuZnZRTyV9jTvetIK
         AsEvceJy+F8umzYXOs2Aer2566XiNUmMbeCi2k9CPeXQ32NJra8/728zL0lm4wGsRzYI
         gdubEMq8GEZ8y1ej5JTKATGXgE6xGGp/Xp2Ar/CwtFf4yYsHMfNN/fwAXfiv94JA2EWK
         63rXwAi6aUNMup+rpobtz4G6SgQAp2sNhqZVN8HJjOFI1qrMabODhN7EfRoI2JNaxG0x
         IJ9+pzsKBW74iR1ORVBw/rIMlXOccxd8voIQrmHFNBx+Fnn22t6krm2zcU9PeEaQ9PDW
         EYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512576; x=1796117376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ak06+rRtQsPupbgxyIs6n4VqFtz0XTJF75o2FEFeOXg=;
        b=cNsaiNjm3SfZN7PV1q96qG+X429u1Y0/oI3dWtpDOWHUMCiuvOeTW1Hj+M9HEkuPej
         Z5XNmXC3dVUqHxlPnb7tcFGDBCM1BoTabnm3i1nptS4ObKgGOU2PdXLf1zgdHg/0AZ0P
         mDQJwR+WAnaOwIb9sZaPNAR3eR9rsqXEVx+XzY5yYH4Xn4Yl1kmkVlC1C25lUl5WcmmS
         f+0njZCBs6luO6JVU3XTc605BlXnl7RP9hTNSICB5W5YVYovg52ZAKNuJziOFxUfkKzd
         tq0Lkr8B2b6upnSKfUM3mu/vJtHADjLwjLZi/lmsMQ3DXKtJxptJgBVqwInCeJmuWeRO
         x3kA==
X-Forwarded-Encrypted: i=1; AL+hErGqNfIZTbNzUN1vR9fb54LOYeYgw0hoyCsVW9Tp6PST5IcKWla2169F3RCx4ae3THYZCMgoqvAwMA6L@lists.infradead.org
X-Gm-Message-State: APuU4Z/3Ydy3mAc6IlGcRlfS3lHGVRkZSkJ1Fr4dJHQjWBvFn0EXtzia
	bxYAtnzvkTZPFxYIOlM9CrPobsqWyIzPWbZF5QGi6Jq+hUPjGSxS5fuqTbOzP+ItSHg=
X-Gm-Gg: AZFdTZfEqDJiRuTMnMG/lQLFoT7RQfMNtPEG7Js8j8eeeeKYepg15V5NFk9qvUTLUwD
	G9bXd2rdkELUeeRq9+EiRbqJRpQ3aiDV6sYSAfZ4yKhCqngSJEnKU2iToWyfQ9O/MuisAYYzgEy
	C8k5fh8PiacZ0+x/3tj9rVt1pnFpbCTwiqbHiRafCj9szUnezBkdkU4md6K4YIk5Cwzr8mQ8PSg
	AYWkhfqyruwrprEYnK0kNZZDpy4NqInUT4+gls4KTqg0ELnzH0dDAJsBaYNcN7/QgwBn1QQz47E
	2JGnPCgY2Cco227MQFdvjgQwKRsWH0AyncRB3tjLZQhhFFaHhH3A5Q0FeZv3nUPidgVXK5EY5kt
	D41Dq2GaX7rOrxD2WGC8aYq7hNwZ+oyrCzrGnxepXJzDsoTmQAtFuDLTuuqUnSC2Tg/7pvaUllA
	rW42KLaYauFARgrsgrjoXCU6HdvvRGgfL95OrOOIWEdOazb9xVDIAhIppoDLGSRWRKL+FP7Xnep
	kMcUTHxRUaHHtnDz37YaIEFASTplKzca/ctSx0lb1LzYIa/AJkJWEniQEgV9UQ5TSafUKtIQzAW
	TFgThyc07mX3KmcVeCMVN0pZ1ekzj0qjvjpejizJ/wjl5NWk5Tz0UDAGjqwEYoOmJYTiZfBfRzv
	Qdk24jIv6IsMqm3j4SRw=
X-Received: by 2002:a05:7301:1a84:b0:386:abfb:4a2 with SMTP id 5a478bee46e88-386abfb1a83mr6976322eec.11.1795512576085;
        Tue, 24 Nov 2026 01:29:36 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([71.202.170.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm54229158eec.5.2026.11.24.01.29.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 01:29:35 -0800 (PST)
From: Saravanan D <saravanand@crusoe.ai>
To: Daniel Wagner <dwagner@suse.de>
Cc: Saravanan D <saravanand@crusoe.ai>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	sgogte@purestorage.com,
	hare@kernel.org,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai
Subject: Re: [PATCH v5 2/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Tue, 24 Nov 2026 01:29:10 -0800
Message-ID: <20261124092915.90075-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <79b5a23a-5ecf-4e96-85c8-031b5eca2867@flourine.local>
References: <20261018010059.83120-1-saravanand@crusoe.ai> <20261018010059.83120-3-saravanand@crusoe.ai> <0ee4d281-61b4-458e-92c6-7fff3e50c0ec@flourine.local> <72fce5bb-b256-42aa-8844-f970c4480ad3@suse.de> <79b5a23a-5ecf-4e96-85c8-031b5eca2867@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_012937_648044_F80732BD 
X-CRM114-Status: GOOD (  16.56  )
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

On Wed, Oct 21, 2026 at 10:19:37AM +0200, Daniel Wagner wrote:
> However, to make this truly user-friendly, I think nvme-cli should be
> extended so it is aware of this and can configure it directly. I've
> merged Nilay's --nr-io-queues patches, so this is the natural next
> feature nvme-cli should support; see commit:
>
> e170d6985797 ("news: document the use of --nr-io-queues during nvme connect")

Hi Daniel,

Now that Keith has queued v8 for 7.5, I have started on the nvme-cli
support and I would like to get alignment on the command shape.

To show the values, I plan to have show-topology and its JSON output
list io_cpu and managed for each queue of a TCP controller, next to
the existing per controller fields such as NUMANode and Reconnects.

Setting io_cpu cannot follow --nr-io-queues as a connect option,
because the kernel only exposes it in sysfs once the queues exist. As
far as I can tell no nvme-cli command writes a kernel sysfs attribute
today, and the only writes are the vendor defaults libnvme applies
after a connect. So I am proposing a new command

  nvme set-io-cpu <ctrl> --qid=<qid> --cpu=<cpu>

backed by a libnvme call that reads and writes queues/<qid>/io_cpu.
When privilege separation is in use, the helper's handle_set_attr()
would gain an io_cpu case that only accepts a valid controller name, a
numeric qid and a cpu number or -1, alongside ctrl_loss_tmo and
iopolicy.

Would you prefer a different name or home for this, for example a more
general command for setting controller attributes?

I can post the series as soon as we agree on the command. If you
would rather wait for the kernel patches to land in Linus's tree, I
will hold it until then.

Thanks,
Saravanan D.

