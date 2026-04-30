Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F1CCD13DE
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 23:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8XVkprBwRfVFj240JgiyGA7uHI3bThzC/n7tmPq6PF4=; b=LkXaAeZYa6LUmpUO/aiqttV8oA
	SrE30DM37Uunw1gnWoTC14+mni3YwqCTZVtpHLQQUaITcKeyRurE7uE3Yjsv2GnLD/OrON/mapGEe
	bx5jJENkojQ7/BD4XKQqQ04hBHcVW0+FCqUW4hJQj3mhlyY874ae658jlJHvjBhCzTHGE/ufBLCGt
	X/3EgHTOLiesW2+eRNNIPVeS8kFLnWbLnDwXog97CPvTwDGDZcC5uqzd3IMLQKSEjKJxsFYZlzucl
	Uv+yAE94I/zan/ybzc2JVHri/WcSV+kJwYsQuEYosLqoP2u11Wb51VS6CB+hqRhzvX3/RE1W1Qzao
	Y6xDjB6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIb5B-000000068D0-1CSN;
	Thu, 30 Apr 2026 23:46:13 +0000
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIb58-000000068Cg-26eZ
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 23:46:11 +0000
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-60fce51aa55so568712137.3
        for <linux-nvme@lists.infradead.org>; Thu, 30 Apr 2026 16:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777592769; cv=none;
        d=google.com; s=arc-20240605;
        b=I1nCwRJhCqgVmOj/32+8Ch1+o5d5kUlZmDrpoVqc4qkXtN4leMYaHFaG3kQTG09zn2
         AouEh9vSXIMF9FhDprmQtbQi7TMwPHgLfa0LW539s8bp+28mfuH7uuV4p7bqbY4SWJ9v
         LWiQBwSCNvzhgfadXvhsT9CSJqZQsrC1eWJt8O9fHXGyTOC1T8XKuNyEg8djTBBvS9S9
         QV4G6O7wSUS9IC39lkbLaydpzxUEgdbwjoYjyU0HWUmj2xaZ/4tdrsR6l6Y51JFIiLZ2
         /r+Jl8jnhKwFd0AMAZci+lP7DblFSWfdequGBznNvHaq/F1L8MJe6bFh9qZdTeQExkL2
         +Dhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8XVkprBwRfVFj240JgiyGA7uHI3bThzC/n7tmPq6PF4=;
        fh=bWLHjdMyCBiATpZo2d56hm0AlZ5QJefkbiVxNlunjak=;
        b=MyQVOVKs2HNRJLGWiGlpy8iUil+U1rAEt53LkWg2Et0EH2vfe4HWRXw3Vx1HBcapNd
         IADaBaptcRVIJDh8740hRpKwZK9EdLMJJ9oxewPKDDIGbpfP8kkbuoeyH5h8+YP8s0AH
         688grVxCIDUfbMriwIaV3eq0HQ1nY4zOi1Fg48m6BEbkPkxf5fh8tYOIAlE9eGfEH0tX
         yeyGb3aTen6DGy25F5OmnHbL4Fk01bYg1AiQ05lIYiiEb2iBLLCReLRAhWSRGr9t15bH
         WCfKPVeaS8OxxtbyRWt5N7LGtOD2QuSlEMNmjb79Diz/FlLbNmSVNjsIo+QzT0I+YA1d
         rdGQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777592769; x=1778197569; darn=lists.infradead.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XVkprBwRfVFj240JgiyGA7uHI3bThzC/n7tmPq6PF4=;
        b=FLLVD4dT42d0GMoe1GBPErQByMDm3ndLW3iFdcv1Vcz+aMAyUPMK/3/JRolSWJEcQ5
         GY8u6/Vv5fpqT7I/eqI6DREeBg/61YviyC+6ykAwcS6zKy3Sy0Q/TzghYWyA7kMGNSLZ
         IhNir6X8UqXdH+eIwDQnWnzLhTmE0QigT8VYRvf0Bx0s0TCD39AlemcsL6vSlhqr+fo0
         DWDg/F6IeXZjL3G8uLqz9y+P/rzlvGVkBpyvWu5HtTScNOc3nvP1xygMK8AftKqs+5Zx
         b2xWpviMTWZsf7usGj2WLiidb0z43s9hMQ1Xn8BMxuAwBX2Kqzs0tODaXgvLVx0k5knp
         5GIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777592769; x=1778197569;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8XVkprBwRfVFj240JgiyGA7uHI3bThzC/n7tmPq6PF4=;
        b=WS50Dl5bWvnmHauwyawYkxoQ5nR1qRI0zT9F9L2RV2jIO1yQN7cqoG+LkUh0g3COvs
         LheLndkREOkyCMdfg75yCXeALG7wmdbglZPNydffdVTVK7XqP1Ph4zzFBqDCN6iMkPMO
         2vTGE4vFJn5qIIW14PVRGWqOnbsVSXhiXyGn11f3Zc4E38hAAiOYTJCiwiC0JFfdfgG6
         KtrU89ddB2Sit1je7RiGlKqeuHnphuKbCWMOaoPte3RAQRFsP1jReSBIs1AndVQZJ1s+
         rqKgkgEEcRPtdmJBcvTH0/RQNUdFUDgS1HIX3z/QMJfwjjvqNvpDgRpHY9QxjVN/36FO
         DIiA==
X-Forwarded-Encrypted: i=1; AFNElJ/yK+OqsuNkHQDFXI2s52eGokndkjvZxrnJKuaCtAj56rGlzlGz3+amQynZw2QJ9Ulkl9qKKVfyFqgo@lists.infradead.org
X-Gm-Message-State: AOJu0Yxu2T4nejrsAq3Aquu/5Cg6Qrc0ipAebw+IwE+dPJ5qXujKt/rq
	HODJSikw2fhSYod6mhiRwt/8CoT8bqATYPYcOqnhjdhMDejNaWPNCCR3ayY7cnt89BWjYkmQzwp
	eBWQ7/iFwUGwABx7+7gtzTLvIQDQyFyFgQ6VSzcmPjDSns+uu2XaAYrQIZ7QI
X-Gm-Gg: AeBDiev2IUCmm0kSL6vahBfXumv+ztUV1YNTtmo6pxxoIRfcqkHZ6U27H4X7lNY0+wb
	SVCUAhi9DyAX66+KgwgSWEzIX52zApZfdaGd3HdW6fJVNTgys+pwWuhD+Iks0vUywO3S/jBgcc4
	bNvs4JMQ+KHero2EdjEKgjGYQh0HEncAuXZ7gDs5HQauBYyMWz68VQ5CpRW+Z+UVm2K1qH7D0cz
	DodfWGTaZAuGr2lwHR3gY7ityLUOPdkWuVUHXTvQkWRvV9Ts32yp4E4/s8/Qe5SzY2MmnztMEft
	yQRAjnNBlzAD1MAJ9X7qTyOefHj0kbz5utwv+hWBERCFCa9js8ppgYQBYHbFKVtnfWE7SeFln7w
	TCmp9
X-Received: by 2002:a05:6102:2b82:b0:607:97ef:4dae with SMTP id
 ada2fe7eead31-62ad384adb2mr3159926137.16.1777592768193; Thu, 30 Apr 2026
 16:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAPpK+O03nHvHGESXsDDARz_kgbNkmeHmu-G3XWto7CqHtyVedQ@mail.gmail.com>
In-Reply-To: <CAPpK+O03nHvHGESXsDDARz_kgbNkmeHmu-G3XWto7CqHtyVedQ@mail.gmail.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 30 Apr 2026 16:45:56 -0700
X-Gm-Features: AVHnY4JsW__O4MVezzjBBm7783Ix8aaG1zHCgESb2EbJw2LCrZyzVBwN9Ko3anc
Message-ID: <CAPpK+O2zkmg0izSt7RjGgeg3hHUwkyLGmQoPcpZ+S3sEk2+swg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Implementation of Cross-controller
 reset/Time-based recovery (CQT) in the linux nvme driver
To: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_164610_578982_F98F4665 
X-CRM114-Status: GOOD (  17.92  )
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

Here is the presentation for next week:
https://drive.google.com/file/d/1IOcakxMCKC8KKrBl4YRWfzojP1_jFoal/

Current posted patchset:
https://lore.kernel.org/linux-nvme/20260328004518.1729186-1-mkhalfella@pure=
storage.com/T/

The target should be built with the code described here:
https://lore.kernel.org/linux-nvme/20260430232913.129271-1-randyj@purestora=
ge.com/
The last patch should be included to fail CCR, excluded for normal operatio=
n

To conduct the test:
* on the target, enable cqt (if testing with cqt enabled)
    * echo 1 > /sys/kernel/config/nvmet/subsystems/mysubsystem/attr_cqt
* on the initiator, connect to the nvme device twice
    * the second time needs  --duplicate-connect if the ip address is the s=
ame
    * make sure the queue policy is round-robin
        * to make sure both paths get IO
* on the target, set the fatal opcode and delay time:
    * echo '1 2000' > /sys/kernel/debug/nvmet/mysubsystem/ctrl1/fopcode
* on the initiator, run the test program, rw_test
    * the test program is hardcoded to use /dev/nvme0n1

test program (courtesy of Mohamed Khalfella): rw_test.c:
#include <string.h>
#include <malloc.h>
#include <errno.h>

#define BUF_SIZE        4096
#define ITERATIONS      255
#define WRITE_COUNT     10

#define WRITE_OFFSET    0
#define READ_OFFSET     WRITE_OFFSET

int main() {
        int fd, i, w, off, ret;
        char *buff;

        fd =3D open("/dev/nvme0n1", O_RDWR | O_DIRECT);
        if (fd < 0) {
                fprintf(stderr, "failed to open device, errno =3D %d\n", er=
rno);
                return 1;
        }

        ret =3D posix_memalign((void **)&buff, BUF_SIZE, BUF_SIZE);
        if (ret) {
                fprintf(stderr, "failed to allocate buffer, ret =3D %d\n", =
ret);
                return 1;
        }

        for (i =3D 0; i < 255; i++) {
                fprintf(stdout, "iteration number %d, writing data\n", i);

                for (w =3D 0; w < WRITE_COUNT; w++) {
                        memset(buff, w, BUF_SIZE);
                        ret =3D pwrite(fd, buff, BUF_SIZE, WRITE_OFFSET);
                        if (ret !=3D BUF_SIZE) {
                                fprintf(stderr, "failed to write buff, "
                                                "ret =3D %d, errno =3D %d\n=
",
                                                ret, errno);
                                exit(1);
                        }
                }

                sleep(5);
                fprintf(stdout, "validating written data\n");

                ret =3D pread(fd, buff, BUF_SIZE, READ_OFFSET);
                if (ret !=3D BUF_SIZE) {
                        fprintf(stderr, "failed to read buff, "
                                        "ret =3D %d, errno =3D %d\n",
                                        ret, errno);
                        exit(1);
                }

                for (off =3D 0; off < BUF_SIZE; off++) {
                        if (buff[off] !=3D WRITE_COUNT - 1) {
                                fprintf(stderr, "validation failed\n");
                                exit(1);
                        }
                }

                fprintf(stdout, "successfully validated\n");
                sleep(3);
        }

        return 0;
}

On Fri, Feb 13, 2026 at 5:09=E2=80=AFPM Randy Jennings <randyj@purestorage.=
com> wrote:
>
> I'd like to discuss the state of patchsets related to implementing
> Cross-controller Reset and Time-based recovery (CQT) in the linux nvme
> driver for fabrics transports.  I expect to present performance test
> results that show the impact on read, read/write, write workloads with
> packet drop and storage controller failover scenarios for different
> levels of implementation (none, CQT only, CCR+CQT, filtering some
> outstanding requests (probably just reads, maybe some admin
> requests)).
>
> Current patchset is:
> https://lore.kernel.org/all/35ae10c9-808a-4882-86dc-311b23c821e5@grimberg=
.me/
> Although, I expect it will be updated shortly.
>
> Sincerely,
> Randy Jennings

