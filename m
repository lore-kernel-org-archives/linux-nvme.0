Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A8606A882
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 01:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DQriGLM7;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vit+Euku
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vZqO0In2n5tOz2hnsdR3SO6+3JMhXipUZdYYnYL8NEc=; b=DQriGLM77OFX//QUzd9gE45hlj
	SRTIBdnTn3fFg/ttznCtMAjTGwzqeqWMbH/ft+vtoLLBGYwpemPQS1NiOPO/r4dXQ2zTpeb+GwISr
	CS4Vd8WIw0b+QmcIeyxpu7a/xmplH74lDfHapo1ljmgVEQ+HaOzC5ZFSUXU0QCkj5avSg4FbKvmnT
	Qim7IZXes05MPF6VGkzBSujkCwQFTq8pO2UVySZ1PMFSeTq+t633ct4yhbSHdVjm08jL+GTbbS/rl
	OVeAxPBV2CoUwFBn8Wl1pfhi6rqy976ZFiHS64Sd5jnjgSp68Q8rWMZ5hIS9TeOF0/1t+EozR/f1l
	fvWCf3JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRK3c-00000008Scm-2yA0;
	Thu, 12 Nov 2026 01:56:56 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRK3Z-00000008ScQ-3Wqd
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 01:56:55 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-18818daa3e7so203022c88.0
        for <linux-nvme@lists.infradead.org>; Wed, 11 Nov 2026 17:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794448612; x=1795053412; darn=lists.infradead.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vZqO0In2n5tOz2hnsdR3SO6+3JMhXipUZdYYnYL8NEc=;
        b=vit+EukutK77e4/L4AydiSK7/QaXmdkDBVyT0DgYFZ50AW8lDyuar90ZyXi3l5HDMY
         nDE0AKTNvsqrv/DoKWL4liUAkRAVEt99okt88ceFXQUUVP8T/XOx4RBS2jLAoBuqJfhA
         +f4Cz8Kkx8n5umsRuKDGZ4t+X2a/Bb1/wxaUoaTEUpoKKuEE3RrTRU/3eAO/2UHgRY/Z
         N43OFCUp5NyH5pYt8UqKqcKY9cSaNUOG+DPdzwkNsx/Hyt/zj6TH9EJ/yP3hfTeqjz02
         hGvQ1c24vbzP5H+PziK+P+KZnlzncIIXrvxQ8z1kee2l50HPGlZ3Jg+QZ7Uo9znfsgWb
         OXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794448612; x=1795053412;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZqO0In2n5tOz2hnsdR3SO6+3JMhXipUZdYYnYL8NEc=;
        b=wDkiVO3ILASsml8MeKqdW98JbWT+KLmXcVAsGzq+AfsFpTFB3oXSklcfN7aqW95MH5
         +XeR04wztUiRybrIKojdZ9p1pXNZwhFbB2yLhMc7IMOfrJM62jWC/hkpcU5/dUqb701a
         4Myc8VnAxhlKly5YGDzkxwx1b3aUCAx4SHakfypWscnkLOjRDdFo5nI53r4w8E1UMybV
         tjG2ePuF0jboq29WifiDqsisozu4YQ3GPkAfk4AWwOCSG/ffmPEllnZCyi4bcqjpok7O
         kRGosN2SJeEJmmK1esl001sGth9FNIU4SSLnJT7gz+Y65PCEb9r+VVo53DLz3jK62j2K
         xgJw==
X-Forwarded-Encrypted: i=1; AL+hErHf2SOGBx0Xf5vOR/vj3Fm5COgZeTyqMT6zaKiXnZ2nzJcXd0zuBvl/P1laP11xrbQ8bqNeM95JGNcr@lists.infradead.org
X-Gm-Message-State: APuU4Z9sG9N8yBhs2OclfjHFRiv4UCMLQz2vrkc0eE+iNpJx4B0Wv7r0
	HLNQz1utBYjlxmk8A227SlcP5vXMG3Rna0TYQdw8SZZz1YSec0FUjgaG
X-Gm-Gg: AYBFou0iE6V6M4DffDLBi42Wmt1zOo3ce5O/5i+Xaka2Jro4Rmnkx+1UmK0ATqFqJzG
	ACndBPsEvEAxbiIA7x2XfEHTCxj16TE2lQbHaE+kym+NciCUNqnL92U73owTKtHyiyK5lCXyvx8
	sZ4DdZCOdF5OsnSk8gGVa+UbH1J6wXVz7du9TDWzl1hvwjU7MtybEk7Wm4UlUVhZxmal03hpyf+
	AhnsZwTqW2npFbiyBNbVpwk1XB7xJ3Bbap9QoZ1LI7e+FWbizTEVbnILTmCLqL+8fzVhikmyaVz
	wXaszw7Gh9Yo6Q7kUtZ9vzOoUCP7JHGVJM8ha/oFzDsYV6sp+wjbrHqIYSkArkf5PgeZaIv+nN3
	T2t0RP7fONAsCIBzmHFRiwfk8Kv82HrJOfEDMFTq7bCKXo+p4IUZrfw10j93v7Ngx4sCqbyi4sn
	eD16xKXl1DhMKsImIN1x9tLDtHFJS4Pt0Z6x1PRsp03aAjukpirRPh8tLJ4TFkF6suPSmsYeTSA
	S/uVpSgobIbhMVAt9IViVT9O6SVxKn2DI6w1O0zwicWnie+EmunBir5N+frHVOI+WZ3MkwJM8B2
	yZ8WSADGuk/129zklPqP7WRu+cKfCpKVkhd1OIhmm6yKUrgGZcQEKsqHs2kOWE1QAXHURvmsfi7
	Oy53JqX9O3AfzI9HPWpK5AuASJLTzqlllRrzSDmpaUJ0wdw==
X-Received: by 2002:a05:701b:42c5:10b0:14e:61bb:ec3d with SMTP id a92af1059eb24-1b4f5eb2338mr1128050c88.16.1794448612207;
        Wed, 11 Nov 2026 17:56:52 -0800 (PST)
Received: from [127.0.1.1] ([2602:feda:30:cafe:ec49:29ac:0:1866])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm21032435c88.9.2026.11.11.17.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 17:56:51 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me
Cc: mkp@kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: stop asynchronous event work before ANA teardown
Date: Thu, 12 Nov 2026 09:56:38 +0800
Message-ID: <20261112020000.1003.yaohan@gmail.com>
In-Reply-To: <508595ec-0540-4534-afd4-44ef8ee01da6@suse.de>
References: <20261105114149.970315-1-shunsheng1218@gmail.com>
 <508595ec-0540-4534-afd4-44ef8ee01da6@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_175653_952023_42CC0DC0 
X-CRM114-Status: UNSURE (   8.29  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hannes,

That's a fair point. I agree that we shouldn't submit new AER requests once t=
eardown has started.

The case I was trying to cover is a completion for an AER that was already ou=
tstanding. nvme_stop_ctrl() flushes async_event_work, but a completion can st=
ill queue it again before the transport has finished shutting down the admin =
queue.

In v2, I added the final cancellation in nvme_uninit_ctrl(), after the transp=
ort teardown, and kept the separate cancellation of ana_work before releasing=
 its resources. Keith has since applied that version to nvme-7.4.

I agree that stopping the producer is preferable where possible. I don't thin=
k the final cancellation should be treated as a substitute for quiescing the =
completion path, and I'll check whether any transport can still deliver a cal=
lback beyond that point.

Thanks,
Yaohan

