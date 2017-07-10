From: cknvme@gmail.com (royy walls)
Date: Mon, 10 Jul 2017 01:40:02 -0700
Subject: [PATCH] nvme-cli: Fix to the logic of the nvme list-ns <device>
 -a command.
In-Reply-To: <11488ccc-3243-5191-08c6-0faa184620a8@huawei.com>
References: <1499560605-16815-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <11488ccc-3243-5191-08c6-0faa184620a8@huawei.com>
Message-ID: <CAGrovxXZSQVN3Rtmii4PPfQxjnaVp3=QyABzejPN0NALXoFz1Q@mail.gmail.com>

With this approach
(http://lists.infradead.org/pipermail/linux-nvme/2017-April/009805.html)
all the future caller's including any plug-ins will require writing a
code with "!!".

I wanted to get rid of "!!" approach which makes the code simpler for
everyone at first glance, only if everyone agrees with that change.

On Mon, Jul 10, 2017@1:07 AM, Guan Junxiong <guanjunxiong@huawei.com> wrote:
> Hi,Chaitanya
> Thanks for your effort.
>
> On 2017/7/9 8:36, Chaitanya Kulkarni wrote:
>> This fix will reverse the logic of the -a parm in the nvme list-ns
>> command. Currently, the -a option only shows the attached namespaces
>> and not all the namespaces. By removing the extra ! it will show attached
>> inactive namespaces with -a option as mentioned in the help text.
>>
> Actually, the approach of reversing the logic of the -a option doesn't
> keep the consistence of literal input parameter __bool__ __all__ of the
> nvme_identify_ns_list function.
>
> By the way ,I had sent a patch to fix this two month ago but Keith missed it.
> A new updated patch of this was sent a minute ago. Hope Keith would catch it.
> (The origin link is: http://lists.infradead.org/pipermail/linux-nvme/2017-April/009805.html
> )
>
> Thanks
> .
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
