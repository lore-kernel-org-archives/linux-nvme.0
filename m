Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825E606A32D
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IYnU03aR;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ww8DKTIs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PW259vEwVt6aepdEMnV/kf0Mt4lpxnzMAqh8bDDexfs=; b=IYnU03aR4ashLr
	ELoRnjwtlb0deCKzh/5CiTAtaf5QQTGhcDxuxs/p8aDZM7sr47tSUP/IMC/A0Ls7hN3YF76a6dAJD
	QxdRm8kU8sjMQ+4RSq5z7Aa7uRM+ASsNf5WGJLQI+PErSfS6b350VLGoln5KEx4JRBqi5ljGFO4o0
	mtVaxfhLG5us6C8WOVQJPcyxpOxrlAMadY0FAXV7f6wFrjHmD9wLdy0MDdnkqlqaevovkJ03l7pMp
	0T+h1t71JTb2z1y9WnDuT1LNEWkhzuJoVt/YEXwSAMA/cgvJ50K8Vkcv8JBBtUQGvcxXEAbvxIVnv
	0XfgkxNGG3s9NkxQeiPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmBo-00000007TDf-1kis;
	Thu, 05 Nov 2026 01:22:52 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmBm-00000007TD6-1ScI
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 01:22:51 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-1a2761c69fbso288060c88.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 17:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793841769; x=1794446569; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PW259vEwVt6aepdEMnV/kf0Mt4lpxnzMAqh8bDDexfs=;
        b=Ww8DKTIs1ySeBlLM+SJPMziTV5fueL7fsuRUfLcwwZxQmnMuci+PtuMFjXfRiPjYZp
         hdEY50zEY6wS89vBJDuob6ZUeuE4WeZ4OVYBYzhLL6fiiXWJ4yzfgtD2eQsqthFI5x6L
         BKYI+FSNWaRfxWpn5oZY5y5ud6ANirDospQbVJ2a8AQbGaBcT4eFqWvlA+0aCoOnYj6n
         yqOzKTZCcBq6/HZ1jlQLORiDVeAp+miQ09ISv4I8j6/foHKbioxm2eTlZUI/Hb4GZvI1
         Pgl48tD0hu8O1tcrKn6ysrsuUz678WLgkVxfPJPEvwQy7ll4kAaGmYK5vHrFYSF261S3
         jRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793841769; x=1794446569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PW259vEwVt6aepdEMnV/kf0Mt4lpxnzMAqh8bDDexfs=;
        b=lQQplkeUyksvNmpl2yi7yLH4AxVl6+7x7N3XT17QSwH9GstDhnOaemFfNlTKl+FgNs
         T4o96603gt8OD+fxQxfogi7W/naRTkg6A7V/q1+bjqQO31L7e7QhF7I+6E4eoM0pP7PI
         HH4aVI7fGJb49REL0GMjTAISVeiDD/yhauwR/XRVZ2vq7H+EWN33jT3QT1h5PFtZsc8n
         RQH8QlPzDr3S09+XUtgRLrAVKsPHDR1zjjVslgtnSre+5+qTFsZFrG5GUgz2QWF5vIKF
         T6CNcwVknPfhQYlxCgXWtH7gN72oKzd2FH6OH3scT+YUTej0Jqzv+feVXPKhdlFW7Ale
         NxHw==
X-Forwarded-Encrypted: i=1; AKwUvBxqSlqlqSaUoR7hsaicLCa6gZPf5zkYOhozLFfAMRI9fp3USMYGpiRooDW35HcA7JP9eObved26rbIw@lists.infradead.org
X-Gm-Message-State: APuU4Z/+yAp8XZhqhgOCgJRXkp40DpEdtzgwIUEO4xdpnn+A9A6qttS0
	cFFhizS3zHIIiyzCRvWwYpgq+2Ull2x44WnS4t7xyIzTsrjwayEBcmFv
X-Gm-Gg: AYBFou0EKU2CgggZvdwx9Ew6KeP+7UOYzcRYaZ7aA37sT7wIjC8FnI5s2aqyZSG/Y1p
	8f7T0V2JpBPCNmv6tzcvBLQdCc4ayhICENzhRhn0/HNJ6lTcDW6OgCs/DM2tGmyzvfX62OzTx/Y
	I5UKj6yxvEWFB2NfOCK0wiUL6bHYWeS7g+6AyPrzY+WX7Q/IAnw9Nkz+TFHheDM3AMTFOcWMxvS
	vBTJH4sE6PE2ZJcvy0ukOIRERd6ORcQWq1hPKxt9lCJBqyvKwRmcPHZ+hrp1uW+BHHcngQm9YCL
	wRhvuFWTcIwepPokAxDMf8hQG6YK+FP/JPT4x3JsfnHFYo/qQFn/Z7XrhmG2DBSrRvhUHgE/mgx
	gr3QZfDK+PoWAoomSyVaDC7fFLFBLu7+I5KTg87ucz1M51SI6RZDEPg3WLrffKbFt2NLM1XOOe4
	1c9L2yyd3aYCfYzD80WdQR5Z4sDIk82TCMUZ7+82KmYIk2DzVvAqEL7zzYeBMIoNWgIovOEeR/j
	pSRhLRJXCC5OE0ihhlEuzrqXTyLzzp3420sHSbFvRIid/NaGKF3aEy/JGrrrCWdfGdNg9AKagVd
	7y+NQGPglIaOnLSlOEE7
X-Received: by 2002:a05:7022:281:20b0:1ac:91b6:8dfd with SMTP id a92af1059eb24-1ade9e3e335mr25492252c88.31.1793841769331;
        Wed, 04 Nov 2026 17:22:49 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1bcedsm11526499c88.7.2026.11.04.17.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 17:22:48 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	=?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Date: Wed,  4 Nov 2026 20:22:42 -0500
Message-ID: <20261105012242.623962-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com> <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com> <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_172250_386084_F0C6EDE6 
X-CRM114-Status: GOOD (  17.37  )
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 09:14:12AM -0800, Paul E. McKenney wrote:
> I am not inalterably opposed to adding a list_splice_init_srcu(),
> especially if quite a few more users show up, but here is what I was
> expecting people to do:
>
> 	static void synchronize_my_srcu(void)
> 	{
> 		synchronize_srcu(&my_srcu);
> 	}
>
> 	...
>
> 	list_splice_init_rcu(l, h, synchronize_my_srcu);
>
> We need at least six uses of the above idiom to break even on the line
> of code required for introducing a list_splice_init_srcu().

That works for a global srcu_struct, but nvme has one per controller,
next to the list it protects:

	struct nvme_ctrl {
		...
		struct list_head namespaces;
		struct mutex namespaces_lock;
		struct srcu_struct srcu;
		...
	};

nvme_init_ctrl() calls init_srcu_struct(&ctrl->srcu) for every
controller, and readers walk the list under that controller's srcu,
e.g. nvme_wait_freeze():

	srcu_idx = srcu_read_lock(&ctrl->srcu);
	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
				 srcu_read_lock_held(&ctrl->srcu))
		blk_mq_freeze_queue_wait(ns->queue);
	srcu_read_unlock(&ctrl->srcu, srcu_idx);

nvme_remove_namespaces() thus has to wait on the srcu of the controller
being deleted, which a sync function that takes no argument can't get
at.

So the choice here is between list_splice_init_srcu(), as Christoph
suggested on v1, and open-coding the splice in nvme_remove_namespaces()
as v1 did. Which would you prefer?

Thanks,
Qiliang

