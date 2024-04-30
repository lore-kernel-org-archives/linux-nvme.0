Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A27C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 05:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nm5KSte9EtNP2GBwmXuE8/J8iLTK3PcKydXJnqqMM4g=; b=PcdsMkYxP+W8MrCD0uByzA7AtW
	LdBGNHnI91392cKvqKA93rH3YIQaMKf890AOP3C7QJLYIN6IcQORVbV5pL0VnwsIQi3jc7DxQN+IG
	LkR/+eT8Zx1de7Ig+cyqfEcKBOAnzxFXK8isHaX3PcRxTeowH2k3NSaE12/tVP60nUHSkOhYYNTQc
	Poc5BN8RH8sPMYRGFhJnISx5Z6vEOnx+UG955rAO62n1r4yXhgfvhxFjGGfdSFhYkWMO/qtdcTdMc
	x8/c8DXumop57QZyrSAAetTOqNenp0GIFTGV4pkNrnH+ke9FAZSROA8CsqONN7WKXcGX5EMZwqAjG
	bTCHcIyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1fl7-000000057cb-00fn;
	Tue, 30 Apr 2024 05:10:29 +0000
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1fl4-000000057cB-2sV1
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 05:10:28 +0000
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2db101c11beso60185651fa.0
        for <linux-nvme@lists.infradead.org>; Mon, 29 Apr 2024 22:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714453824; x=1715058624; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm5KSte9EtNP2GBwmXuE8/J8iLTK3PcKydXJnqqMM4g=;
        b=VeETlw8WEMa9XGZ/ecFOZcMndmXdzAibtSjpwhr9xwunYgPpe6uNNWfsc2nBsI1Hbp
         bXSotCOm8r++00v+yVVmdiyZzHw4dhb2ytPpAHEb+HWJqOzomVtPHPi48BVtJp9o7HRS
         zpKsBS2U4+AMOd7qNRceBB24dN19yqHhbLDqLGKGfqrAI+aDI52qCm8ondcyqvKLn8u8
         urlDItrGK2Zwga5BMZVDvDJ7+O5JvKVhWPFLQWOA9mW6oVmqIHTW+Mz2crhrZZg+w1Ox
         8AhOCxsTN/8nOU1ZKBRb/48bMVqeDJ59j/UFlcx7mzGuSJUCAXacKMX/dhAUYqq1wDaL
         NShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714453824; x=1715058624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nm5KSte9EtNP2GBwmXuE8/J8iLTK3PcKydXJnqqMM4g=;
        b=Ie/twAjdSv1cbjDx0Kuecm3D9u7CYBSwzJjSSPF8nmKec+NIBvQtNMmgdB2A7hruRK
         au52MWYEsyoE23zZ1Cm/uPmLUO0m8+UNHBotl35VbCCroV7hWVKuuO2Hi9UbsI6TiFHf
         /hbcBGeNgYqrr38p/5SCYhoYPgRA4/tArUlhSf9Sj8z22djWop9RGI2iScHJxGRpLsUK
         luhUyINX/Ge37vPiSsDGTyUd9QfXx7bimD87IUvCVLxrhdKfV5uS0eVOMa7ha6oEFgaH
         ASjDXmm/K94L5pLhf1l/ziScMUONnlJa+zi1WNl99iMijjLtjgWQVUTVkQC0GTcYx8DN
         bgKQ==
X-Gm-Message-State: AOJu0Yy9fF9f0vc4S3WuIBnLG9D/04Zr51kSnyouRMFNH7VuZG0qESVH
	9oaJBPKVvJE7X819qg2nY1h9ktQuUjMyepKLcWhCH9y9quI+Ey0wsf6ttO2C288vP4MHYBuAqLk
	ua8L/rPe3kcOT0vjBogjjr2N7nCU=
X-Google-Smtp-Source: AGHT+IFlfuijYlZUPjalT0bDu+MnlCDwx6EUmLuwJiu1cUJxg8OL495gJRHS9/N1pnZDUvSNoNy44ns4wxPnk4L5vS8=
X-Received: by 2002:a05:6512:3294:b0:51b:567e:7ea4 with SMTP id
 p20-20020a056512329400b0051b567e7ea4mr998553lfe.26.1714453823614; Mon, 29 Apr
 2024 22:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240430021753.385089-1-brookxu.cn@gmail.com> <8379e4a9-3114-4d35-9d1f-81ca61351b85@nvidia.com>
In-Reply-To: <8379e4a9-3114-4d35-9d1f-81ca61351b85@nvidia.com>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Tue, 30 Apr 2024 13:10:11 +0800
Message-ID: <CADtkEechcseDatdzoPDrYBapvQ5iTKo3E-tsdiwj2B7euLLwnQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-fabrics: use reserved tag for reg read/write command
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>, 
	"kbusch@kernel.org" <kbusch@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_221026_759580_1CC62693 
X-CRM114-Status: GOOD (  22.81  )
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

Chaitanya Kulkarni <chaitanyak@nvidia.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=88=
30=E6=97=A5=E5=91=A8=E4=BA=8C 11:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On 4/29/2024 7:17 PM, brookxu.cn wrote:
> > From: Chunguang Xu <chunguang.xu@shopee.com>
> >
> > In some scenarios, if too many commands are issued by nvme command in
> > the same time by user tasks, this may exhaust all tags of admin_q. If
> > a reset (nvme reset or IO timeout) occurs before these commands finish,
> > reconnect routine may fail to update nvme regs due to insufficient tags=
,
> > which will cause kernel hang forever. In order to workaround this issue=
,
> > maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
> > tags. This maybe safe for nvmf:
> >
> > 1. For the disable ctrl path,  we will not issue connect command
> > 2. For the enable ctrl / fw activate path, since connect and reg_xx()
> >     are called serially.
> >
>
> Given the complexity of the scenario described above, is it possible to
> write a script for this scenario that will trigger this and submit to
> blktest ? not that this is a blocker to get this patch reviewed, but
> believe it is needed in long run, WDYT ?

Thanks for you reply, I can easily reproduce it in my VMs by following step=
s:
STEP 1. In order to reduce the complexity of reproduction, I reduce
NVME_AQ_MQ_TAG_DEPTH from 31 to 8

STEP 2. Create a nvme device by NVMe over tcp, such as following command:
nvme connect -t tcp -a 192.168.122.20 -s 4420 -n
nqn.2014-08.org.nvmexpress.mytest

STEP 3. Buind and run the c++ program issues nvme commands as followed:
#include <sys/types.h>
#include <signal.h>
#include <unistd.h>
#include <vector>
#include <set>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>

const int concurrency =3D 64;
std::set<pid_t> chlds;

int __exit =3D 0;
void  sigint_proc(int signo)
{
        __exit =3D 1;
}

int main(int argc, char **argv)
{
        signal(SIGINT, sigint_proc);

        for (auto i  =3D 0; i < concurrency; i++) {
                auto pid =3D fork();
                if (!pid) {
                        while (true) {
                                system("nvme list -o json 2>&1 > /dev/null"=
);
                        }
                }

                chlds.insert(pid);
        }

        while (!__exit) {
                if (chlds.empty())
                        break;

                for (auto pid : chlds) {
                        int wstatus, ret;
                        ret =3D waitpid(pid, &wstatus, WNOWAIT);
                        if (ret > 0) {
                                chlds.erase(pid);
                                break;
                        }
                }
                usleep(1000);
        }

        // exit
        for (auto pid : chlds)
                kill(pid, SIGKILL);

        return 0;
}

STEP 4. Open a new console, running the followed command:
while [ true ]; do nvme reset /dev/nvme0; sleep `echo "$RANDOM%1" | bc`; do=
ne

We will reproduce this issue soon.
>
> > So the reserved tags may still be enough while reg_xx() use reserved ta=
gs.
> >
> > Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
> > ---
>
> -ck
>
>

