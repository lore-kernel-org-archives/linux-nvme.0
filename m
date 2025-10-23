Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107DFCCD1BC
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 19:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7K/5org+RE12u94kWINaZqrKuzfu8gGu9fC3i1OMh3w=; b=xo616deDwxdICl2tttKGPOl5hM
	yCqvvuw94lj1Eg/Qt+xBr1+ZCS/uvkaEQx+e6cjCL384jn9yHIKlP8U5hoGmvQsO5+u+zjT8T+Lvl
	ePj5xHYMQVHERXVNlddfp4TLiQz+3ecHohLzShUxQ6+IHVZR0UPF2lb3TH5wrxgn8Ef5lfpoO7qsB
	w+S/U5PkXeJwVotLQ8/cCq05FKfczrXJtjjo6LFlx336TSvgIVhWNrWBT1hJlg6D26VvrsW3B/i6Q
	93+IdoLOyh8O5ETbbWhYpZaMMEarj/mJAHG4nNaFJgU0sUde1u3T3PM1LUCLVrMEDFwtlE+EGoyBs
	NGmGRnMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC0ja-00000007L4c-05AW;
	Thu, 23 Oct 2025 19:12:26 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vC0jT-00000007L40-0sdE
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 19:12:20 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-269640c2d4bso1927035ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 23 Oct 2025 12:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761246738; x=1761851538; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7K/5org+RE12u94kWINaZqrKuzfu8gGu9fC3i1OMh3w=;
        b=H2q2/+kmSTWF+Y26HD/FaL+7pfPK1691Q3ha6cvXqXMk9iUHctWBfhwmg9iJ57Vrt0
         O27zQVm4kTE3e7zlq47f3q6e5cwCL21dRzx8EK2FIUBsYq5nRR7hsRuIzZFiL/do9IgQ
         D5PuXdbCQsmjpfvHCMwjh21ITEOOi3v3BmMQfVQqhyw29OV0f6SUifXhXIZBBq/9nM/g
         RiyK1TYhEjMI/MGgcDKqE7/RhIjVy/JYsLluoXVEhjqUYIULWlGaRDtO4Ik1nRw2bZNy
         a3gwSpWYkh1AIvlaQLaexhRb/pyn/cegJPw4CZNk4TqU9mE8qjpctN+KDMtGe2LgDqjr
         Zf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761246738; x=1761851538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7K/5org+RE12u94kWINaZqrKuzfu8gGu9fC3i1OMh3w=;
        b=hkMEecmQj7ObXx6Z//fXa+aMThC8917nYf3ewY/UWXb/YAjnqCDuVWec25nd3fB8px
         Jd7DxaTc1yj4syuIjdbScbMC3VOiAZoDL4aNeivHs45/p80PW+XqiJ3asQ30CnPXJMcY
         5r0bKXZIX+hqR5sRKUHJN6kk5tG4mfK6hULWcrzJOJMarncCCIXLk36rGizNR+rS73J/
         0fm5LDhsbAyz8qtYXj4SYmB34JvkLB/+NSkN8vIcl4R+B0TfUW/IxhOq5Wm9CQ+t66LA
         G6f9hrkwzjQ1WCjRql0/jjmc7ijjPXxilEDOQMwxeuD3Wc8F7g/aCC46ZU8yGEaZoD1Q
         LdfA==
X-Forwarded-Encrypted: i=1; AJvYcCWtyVJ5wHBZ0HMht3EL35TLNFcGanFNeJtQdQfjpl7En0t3idu/bTgQEc+ipYwq9bPR5Cpx0BROuWc3@lists.infradead.org
X-Gm-Message-State: AOJu0YxxK70rTCHuVqPXtFcpYyjLoNBmfQMifyNzDdJ5VexVP2rqogxJ
	0nHmpeW/zxwOufzPNA6OVapdIE20Sc50eSbLOI8vaEE7feXHEZxKHrR26FS/h6Aelh5vnEm1Oca
	qgj5kprY9S4ROQgOTMi804dOi+QGB6iLPWFJhiw/qXw==
X-Gm-Gg: ASbGnctP6/M7nlJaPin3U6OyGVMU4C9McjoLGyGWxywohRzABWQs4PPRJoSe0A+xg3M
	jz5koEDp7mK3j5+dw4yr58DaeaCb9wcBZRQ+6SKnKqTxg1WzKKAkOLLTCvkDJ8/n0UI0D62szyi
	rPvA/yKXX6h9g96YV0zDfgBYcIojQ8T4aivz3yWl9PmOZMpOECiw4X02CORIRlv/XeqQ/mABiwN
	lXVz1FjzYrmCitgxb+K/8A0ssPl5t9vd2Lic6AX8JVA/KoE3Mk6gw93Ady9J9uMGIjqeOOfDyni
	uwfrQiurZAgiRzYgZSr1wocz55+9iObshzt+X4P2
X-Google-Smtp-Source: AGHT+IFS1hF1mKJs9xtEGggpEYx3hS9IactTEcTVuTqq3cz04fXfG2tDmrwqCzZgwa2XisCpo38KJZa1Jx+ld2uWSgM=
X-Received: by 2002:a17:903:19e6:b0:27a:186f:53ec with SMTP id
 d9443c01a7336-290cc2023d8mr183803265ad.9.1761246738317; Thu, 23 Oct 2025
 12:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251022231326.2527838-1-csander@purestorage.com>
 <20251022231326.2527838-4-csander@purestorage.com> <20251023134047.GA24570@lst.de>
In-Reply-To: <20251023134047.GA24570@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 23 Oct 2025 12:12:06 -0700
X-Gm-Features: AS18NWCMPnrkTE6bRuzJFrSEBQu8dMm91LH9slk7_UilpxZ_vUHOFG7TTmSOab4
Message-ID: <CADUfDZoMJ26nS9qzk1ACKX_MXkSpBy1kEEkekZoHyCrHtrGZRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] io_uring/uring_cmd: avoid double indirect call in
 task work dispatch
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>, Ming Lei <ming.lei@redhat.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_121219_454417_FB4C5EB6 
X-CRM114-Status: GOOD (  17.11  )
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

On Thu, Oct 23, 2025 at 6:40=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Oct 22, 2025 at 05:13:26PM -0600, Caleb Sander Mateos wrote:
> > io_uring task work dispatch makes an indirect call to struct io_kiocb's
> > io_task_work.func field to allow running arbitrary task work functions.
> > In the uring_cmd case, this calls io_uring_cmd_work(), which immediatel=
y
> > makes another indirect call to struct io_uring_cmd's task_work_cb field=
.
> > Introduce a macro DEFINE_IO_URING_CMD_TASK_WORK() to define a
> > io_req_tw_func_t function wrapping an io_uring_cmd_tw_t. Convert the
> > io_uring_cmd_tw_t function to the io_req_tw_func_t function in
> > io_uring_cmd_complete_in_task() and io_uring_cmd_do_in_task_lazy().
> > Use DEFINE_IO_URING_CMD_TASK_WORK() to define a io_req_tw_func_t
> > function for each existing io_uring_cmd_tw_t function. Now uring_cmd
> > task work dispatch makes a single indirect call to the io_req_tw_func_t
> > wrapper function, which can inline the io_uring_cmd_tw_t function. This
> > also allows removing the task_work_cb field from struct io_uring_cmd,
> > freeing up some additional storage space.
>
> Please just open code the logic instead of the symbol-hiding multi-level
> macro indirection.  Everyone who will have to touch the code in the
> future will thank you.

Sure, I can send out a v2 with that. My concern was that
io_kiocb_to_cmd() isn't really meant to be used outside the io_uring
internals. But I agree hiding the function definition in a macro is
less than ideal.

Thanks,
Caleb

