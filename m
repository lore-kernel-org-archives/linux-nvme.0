Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76033C27C79
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ksWqd5WAJRQ1hrpGnWnokNldHaNsMObK8Ln6xOwg5ew=; b=HIgJRwgYRE7DBfCmcGdznOWf+l
	eDFnrcqvInRC40hXry7hxf+q43wFvQKPV/NOc1V5BNt+C//tadxrIaiANrEP0rUaqj/gUfXt9pSkQ
	QS1LVnsut0Gi899zJNj6f3a0Yg9P+h7ytuEb9UXuUttt626uYzpfOc0OtE9rJDNKPI1fpCs1ATWlJ
	B16BnfPM6gn0jOzcwKbnJJGf9MdtmiF3wiY+BruEPa1WbAzCBkRQX1Y1G47PwUiReFdIG9KmOlan+
	OtRuEbeWnYk9nZPtK+oVCgsOYMS911y1j7c7IDdo1bzaJv7HlxHfyxXqZFkA3K/F88R0s1OKn5flw
	o4b4h8ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKINF-00000005KiR-10er;
	Thu, 20 Jun 2024 14:02:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKHQ0-000000053Vn-3WJw
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 13:01:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718888495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksWqd5WAJRQ1hrpGnWnokNldHaNsMObK8Ln6xOwg5ew=;
	b=G53JmMqgEGOrv45ORaKplah88PJ59gSgEHnl0RAmqJJlxEcLFLYDuuIBvJwDKaw5ixv1+m
	NEV66Y+0nHsdF02GYBPMIwUO1IU2IfB8oMKA42ANZnmgex7Y1umWHE1gOVPCLtv8fD0VAi
	u9HKeApNhwn3PWK7/pM6NeRziQWPIQE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-qhIGQc5tPHGdbJObDZIP2g-1; Thu, 20 Jun 2024 09:01:33 -0400
X-MC-Unique: qhIGQc5tPHGdbJObDZIP2g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b07ef34bfcso16258116d6.1
        for <linux-nvme@lists.infradead.org>; Thu, 20 Jun 2024 06:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718888493; x=1719493293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksWqd5WAJRQ1hrpGnWnokNldHaNsMObK8Ln6xOwg5ew=;
        b=QEDE6sGjCmNG7ssVsGr4Vb7nsmp9vyr7XpzJQ+WtjrZxKFpkSwRnmrLyOzEDJGXNOA
         tuSvB7kqq7ZIxG1TeJcMrNW1F9ZASWDdUhQnO8Cm7lCRjDHvwDa5lldpr1bXpuD+KD6T
         2Q/2MLz8q2VtvnbsYvVkcl0SXG8XmhPEP25OUocrstIQhh2jp+VXmIrAUndNZgwSu8yy
         bdbwm1A77hphmAKUiSxPDf/pacZ4CwI2Pkiej/xMkB/Wmk7HqCGCmulQvU5R23VqV3yz
         Tn7UEUHLg6OrNLdXnH91sK82+FazRUBNgyb5ssrvQzD8oePp/lxbtVepp6DrcyfrnvQU
         KTog==
X-Forwarded-Encrypted: i=1; AJvYcCWvKclwyf+9Fy0dmI46uJL3E2tdhRYyiMEmzIFjHILoPSXqdV/mpNVwB0I/+yztMtc2xSPIs3muyhPE5WspZBJSEhWSZkEDiwP/KN0H5NI=
X-Gm-Message-State: AOJu0YyBgAJs1Sf3FtWPbESsQoBKDNi0bDxo15vz+/K96GSq8hbHoZU1
	1XUIW5FVN+xvqo+F6SC6QeorK2agyUrr2ZP8hhao7Ej4TcrZ3zM8lcz8zSGXaMTeBibt5LTDzf1
	Ezho+bZf8Qy+AUaOKj2oRTh+SmcJqRFsTyXIN4gkRp9JuFOBq5miZt8AZkFs0uFMHXPPQKxJ1+s
	AAt2p7AZyd7lOHxh5fNQSuXqsLYCXCa/t1UvHMMAs=
X-Received: by 2002:a05:6214:1c0c:b0:6b5:a10:aad2 with SMTP id 6a1803df08f44-6b50a10b1camr67056276d6.4.1718888492742;
        Thu, 20 Jun 2024 06:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzfyb9DLFnNvkzhHvzTRFjbeq92d6bsu+gr9zGNL0d9hMhBjV6oDAqOKXTVFQHhbiFZerDWT9gj8xZ1U2zDhc=
X-Received: by 2002:a05:6214:1c0c:b0:6b5:a10:aad2 with SMTP id
 6a1803df08f44-6b50a10b1camr67055956d6.4.1718888492494; Thu, 20 Jun 2024
 06:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240510163026.786898-1-mlombard@redhat.com> <20240510163026.786898-3-mlombard@redhat.com>
 <3d2dc04f-86ee-4802-98f7-fc948e813ac0@grimberg.me> <CAFL455=srQgXzME72mihwaRJ0P4nNfC7VWn8HLAEbdx6o6Jawg@mail.gmail.com>
In-Reply-To: <CAFL455=srQgXzME72mihwaRJ0P4nNfC7VWn8HLAEbdx6o6Jawg@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 20 Jun 2024 15:01:21 +0200
Message-ID: <CAFL455mu9gW4T72KkC8D--CxgLMapde5DqrzwrEhvfvnCgrcbA@mail.gmail.com>
Subject: Re: [PATCH 2/5] nvme-core: add a function to submit a cancel command
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kbusch@meta.com, hare@kernel.org, emilne@redhat.com, jmeneghi@redhat.com, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_060137_294768_CD438362 
X-CRM114-Status: UNSURE (   8.05  )
X-CRM114-Notice: Please train this message.
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

=C4=8Dt 20. 6. 2024 v 10:31 odes=C3=ADlatel Maurizio Lombardi
<mlombard@redhat.com> napsal:
>
> if we reach "cancel_limit" we can always fallback to a controller
> reset.

... or wait for it to free up a slot, like nvme-pci does.

Maurizio


