From: huhaiyan@huawei.com (Haiyan Hu)
Date: Thu, 12 Sep 2013 15:16:18 +0800
Subject: failed when git clone via http
In-Reply-To: <CAMjVwgRcs_ty5c3fOK_uVbW3zZyjtjjJan+iaEOjTPqFStjTDA@mail.gmail.com>
References: <52301B13.9060307@huawei.com>
 <CAMjVwgTOhaueAcQPJ+OU=-HjqFs_gF0CM5w=cuyEPJovekDqaA@mail.gmail.com>
 <CAMjVwgRcs_ty5c3fOK_uVbW3zZyjtjjJan+iaEOjTPqFStjTDA@mail.gmail.com>
Message-ID: <52316A42.5010100@huawei.com>

Accessing the repository via git works well.

Thank you very much.

Haiyan Hu

On 2013/9/11 20:08, Angelo Brito wrote:
> I have googled your error and found this:
> https://help.github.com/articles/https-cloning-errors
> 
> If your problem is not in there try using the ssh or git over the
> https like this:
> $ git clone git://git.infradead.org/users/willy/linux-nvme.git
> 
> And I had the same error over the HTTPS interface. Used the git and worked fine.
> 
> 
> Regards,
> Angelo Silva Brito.
> Undergraduate in Computer Engineering UFPE
> http://about.me/angelobrito
> _________________________________________________
> 
