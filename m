Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64988C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Dec 2021 09:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TK+GUGEkGFc6gtexYGWrCyU1LlZcTY0G631brbTVbMc=; b=Wb4eIZHTpiLxHEhjTY1nGFA2Wu
	9cn39LWkmM4pYIXOFe2b+RQOYrj3oVumPX+heS0PvsR2fsuqPS7DEf96utALXnQYzYAScxHo+lFyO
	rZJPxhRGl1tjmy9aaNflTXBxHQLRm2HZ/OawcqlaFjDgXSTfZb7cv8q5IAfpXoOh06fMAtO2dUfX/
	HC6v6rtLiW98vLTdfE8IRUH9Qz8Y8M5pp2o3LN9sH6y/LycQXbT8v44NApxjeUTfFUezJ0OxlwIAY
	ajfyCRya70rjExQOmHQKu18UuY5Uh5gv7ffp3jipucv/m1EKRxW2BZuZ/b6n/T2UATDiGg6AMSGjB
	PQfCfjDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwLDr-006Ey7-90; Sun, 12 Dec 2021 09:32:47 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwLDo-006Exj-GB
 for linux-nvme@lists.infradead.org; Sun, 12 Dec 2021 09:32:45 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 77-20020a1c0450000000b0033123de3425so12110207wme.0
 for <linux-nvme@lists.infradead.org>; Sun, 12 Dec 2021 01:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TK+GUGEkGFc6gtexYGWrCyU1LlZcTY0G631brbTVbMc=;
 b=FVh4q21mVEhQnXr6iCZOB6G3bDhKtCDr0+LzY3HBxnMO1cJZz00JFBqc6lax0bT3bR
 PoRDGuVZY8cB9WzZp9OUGOfxtnG0hU8Ue78u2Jf1E1C4+a5yW1q3YzMNSJXeolbH4ltN
 YZKy1B8GSWYo9r7El7g23oT4SIoYN4PpNasI0CrVYrkhz1fYYfu/D1jYND8Po8UoBEvf
 6GVJZ8ljOA/vbVMRdUrXAU/90zsdDZKKTrhYgGR0SDxHUF70pVYQ0gFibtrFCirFkNbo
 QPvDAehLcYXufQXJt3rg9t2eQ6dExld8mTdxgkMs17zLn5lXs8jjf9yNp0D4oc0poyvv
 V7rw==
X-Gm-Message-State: AOAM531mJcTj3zJmdfh6dU7Fm8fkYAE6USxYF6rV6qSv96uouU/WvUlz
 /hj3Vi/BFjHoc2jbnbGtNfskJrVEwHs=
X-Google-Smtp-Source: ABdhPJwTGIo0KISi2eMT9YJZgUxzHtbxVz6MIAyIbZvRJ5iIdzuBBNKwXPXxyFiW5tfkqL5JxwHtiw==
X-Received: by 2002:a05:600c:4e51:: with SMTP id
 e17mr29250460wmq.127.1639301562873; 
 Sun, 12 Dec 2021 01:32:42 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id a3sm4725634wri.98.2021.12.12.01.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Dec 2021 01:32:42 -0800 (PST)
Subject: Re: [bug report] NVMe/IB: nvme disconnect -n testnqn need more than
 1min
To: Yi Zhang <yi.zhang@redhat.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs_ZmoGhVy3tZKtCY9TMCiXFR1RofswaAXKBB1VYm2zdcw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8ed5703f-c972-0ab2-a081-b023311e012b@grimberg.me>
Date: Sun, 12 Dec 2021 11:32:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs_ZmoGhVy3tZKtCY9TMCiXFR1RofswaAXKBB1VYm2zdcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_013244_598404_673CC44F 
X-CRM114-Status: GOOD (  11.28  )
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


> Hello
> 
> I found the nvme disconnect always needs more than 1min to be
> finished, could anyone help check this issue?

Yi,

Does this happen with rxe? didn't see this in my test VM lately.

> 
> Reproducer:
> + nvme connect -t rdma -a 172.31.0.202 -s 4420 -n testnqn
> 
> real    0m4.673s
> user    0m0.000s
> sys     0m0.005s
> + nvme disconnect -n testnqn
> NQN:testnqn disconnected 1 controller(s)
> 
> real    1m9.028s
> user    0m0.000s
> sys     0m0.187s
> 
> client:
> [  283.966930] nvme nvme0: creating 40 I/O queues.
> [  288.527028] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> [  288.530501] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.202:4420
> [  288.533203] nvme nvme0: Removing ctrl: NQN "testnqn"
> [  357.534154] nvme nvme0: I/O 18 QID 0 timeout
> [  357.539644] nvme nvme0: Property Set error: 881, offset 0x14target:
> 
> target:
> [  229.016490] nvmet: adding nsid 1 to subsystem testnqn
> [  229.044861] nvmet_rdma: enabling port 2 (172.31.0.202:4420)
> [  280.697930] nvmet: creating nvm controller 1 for subsystem testnqn
> for NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0056-4c10-8058-b7c04f383432.
> [  291.155204] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> [  291.162238] nvmet: ctrl 1 fatal error occurred!--

Will have another look.

