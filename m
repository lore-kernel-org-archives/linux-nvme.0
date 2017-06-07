From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 7 Jun 2017 08:46:18 +0300
Subject: [PATCH v3 for-4.13 1/6] mlx5: convert to generic
 pci_alloc_irq_vectors
In-Reply-To: <CALzJLG97HkMQ8AULoTS+P5FLXhh+2DhjVfVHRYEemea90tXJAw@mail.gmail.com>
References: <1496644560-28923-1-git-send-email-sagi@grimberg.me>
 <1496644560-28923-2-git-send-email-sagi@grimberg.me>
 <CALzJLG97HkMQ8AULoTS+P5FLXhh+2DhjVfVHRYEemea90tXJAw@mail.gmail.com>
Message-ID: <88e732d0-2c99-5317-318d-15c491f07518@grimberg.me>

Saeed,

> Hey Sagi, i am sorry for the late review, had some old mail role that
> made me lose some rdma mails.
> Anyway i have one small comment here, But if the reset of the series
> is ok, i don't want to bother you with another V.
> so you can just ignore it if you wish to.
> 

...

>> @@ -350,9 +344,8 @@ static void mlx5_disable_msix(struct mlx5_core_dev *dev)
>>   {
> 
> rename to mlx5_free_irq_vectors to keep a symmetric function naming

Yea I should have done that,

I'll fix and send v4.

Thanks
