From: harryxiyou@gmail.com (harryxiyou)
Date: Mon, 1 Sep 2014 13:22:38 -0400
Subject: NVMe multi-core process
In-Reply-To: <CAD+1EGN1P1=0Le0Z7Cd3WdC5Q3+Eca+SKFpzdfEQwpqg3LhR=w@mail.gmail.com>
References: <CAD+1EGN1P1=0Le0Z7Cd3WdC5Q3+Eca+SKFpzdfEQwpqg3LhR=w@mail.gmail.com>
Message-ID: <CAD+1EGNpF2=zoZ2kTF21ud_6VHC+nZq5jFW3p3y=NkaN0tNP4g@mail.gmail.com>

On Mon, Sep 1, 2014@1:10 PM, harryxiyou <harryxiyou@gmail.com> wrote:
> Dear Keith,
>
> I saw following words in the NVMe specification but I cannot see the
> related codes
> in the linux NVMe driver.
>
> "Typically the number of command queues created is based on the system
> configuration and anticipated workload. For example, on a four core
> processor based system, there may be a queue pair per core to avoid
> locking and ensure data structures are created in the appropriate
> processor core?s cache."
>
>
> I don't know how to configure NVMe to run it on multiple cores?


Maybe, I have found the related codes as follows.

1524 static int __devinit nvme_setup_io_queues(struct nvme_dev *dev)
1525 {
1526     struct pci_dev *pdev = dev->pci_dev;
1527     int result, cpu, i, vecs, nr_io_queues, db_bar_size, q_depth;
1528
1529     nr_io_queues = num_online_cpus();
1530     result = set_queue_count(dev, nr_io_queues);
1531     if (result < 0)
1532         return result;
1533     if (result < nr_io_queues)
1534         nr_io_queues = result;
...
1575     for (i = 0; i < nr_io_queues; i++) {
1576         dev->queues[i + 1] = nvme_create_queue(dev, i + 1, q_depth, i);
1577         if (IS_ERR(dev->queues[i + 1])) {
1578             result = PTR_ERR(dev->queues[i + 1]);
1579             goto free_queues;
1580         }
1581         dev->queue_count++;
1582     }
...
}



Anyway, thanks very much.



Thanks, Harry.
