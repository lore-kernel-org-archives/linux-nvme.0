Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2090BC25B67
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 07:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:In-Reply-To:Date:References:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o7H7QSHlCPD9A7O5XZYfMPPXmpLVeyrGndbX7Mquujk=; b=isj7H+Xj7D0QgIh2cUaCM5MiMH
	WedLehFhB4GdUQs/QSod1PFhqBp0hOEKECB0ZqOFtO8C0CW0jYa6kzOpTapfW+Bsxli3p9Ztb9VBX
	QnaFs0gohTqYSbSxx6iEH53jkuAq0rIO+pOhsVUAHqeevTt4xS2aGkZvnKXVQVUzM9cx6NuQPEm18
	eoB1MdN6V4XyvMNNldaByoFSqjG0ANhKfQ8hrBQe9e7Kc4cgbbxKPzOBtb01ne5JZ80qWGXBrwmOr
	VAo+6X375hhWpioctkhbPkpiEx5XzdJmeYnJxLNm4hDKWneOriuu/rRXxER/Ceey/Y6MP95sxuV0m
	f3emJ6FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwGxr-00FjsZ-26;
	Fri, 27 Oct 2023 07:09:03 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwGxo-00FjqH-0I
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 07:09:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id A3A57B80B7E;
	Fri, 27 Oct 2023 07:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FB8C433C7;
	Fri, 27 Oct 2023 07:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698390538;
	bh=5WPvMZXHj6SnWHKzmjOCyWmBTsevR5RWBT42u2tYT6Y=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=djguQmPRxLNmjYP9HHUj67/uEd0zfx8KeWVkiz51AIIpYw2lVH8qW0B0MfbRpUIje
	 pLMOnDUaSzl386rS4fNWyfCgOeKql4iaRefnSH/kI+FVAQpkkZCMg8hov4dFdILjul
	 dR3cUtJP2hF2h42zhQlsXvQCJhrobipu1HPqu90ilKmuDpqKFMemvGiECLBlxdyaBC
	 T6N1ZSbC2tYoRhhYmIbdtxYWULzyhqeqkzZzN46peCq7r9cGKFs3j2UaIgQ60dIlPg
	 Gjn4IcKGoXoNZoHAyQJZfHbpDDcCtF60mGs4pQROGMlEwgaN1hFfZsBxI5KZa9cEJg
	 2/5rGVP9O4Rfg==
From: Kalle Valo <kvalo@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,  James Bottomley
 <James.Bottomley@HansenPartnership.com>,  Christoph Hellwig <hch@lst.de>,
  Kees Cook <keescook@chromium.org>,  Justin Stitt
 <justinstitt@google.com>,  Keith Busch <kbusch@kernel.org>,  Jens Axboe
 <axboe@kernel.dk>,  Sagi Grimberg <sagi@grimberg.me>,
  linux-nvme@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-hardening@vger.kernel.org,  ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
	<20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
	<20231020044645.GC11984@lst.de>
	<CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
	<202310201127.DA7EDAFE4D@keescook> <20231026100148.GA26941@lst.de>
	<710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com>
	<20231026095235.760f5546@gandalf.local.home>
	<874jid8one.fsf@meer.lwn.net>
Date: Fri, 27 Oct 2023 10:08:53 +0300
In-Reply-To: <874jid8one.fsf@meer.lwn.net> (Jonathan Corbet's message of "Thu,
	26 Oct 2023 08:05:41 -0600")
Message-ID: <87bkckczju.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_000900_283920_0E6B86A5 
X-CRM114-Status: GOOD (  10.09  )
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

Jonathan Corbet <corbet@lwn.net> writes:

> Steven Rostedt <rostedt@goodmis.org> writes:
>
>> On Thu, 26 Oct 2023 07:39:44 -0400
>> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>>
>>> While it's nice in theory to have everything documented, it's not much
>>> use if no one can actually find the information ...
>>
>> Does kerneldoc provide an automated index?
>
> If you go to https://www.kernel.org/doc/html/latest/

BTW there's now a shorter URL for this whic is really nice:

https://docs.kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

