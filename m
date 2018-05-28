From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 May 2018 08:00:15 +0200
Subject: [PATCH] nvme-loop: add support for multiple ports
In-Reply-To: <CAK0tqim+wxwJ+KA+j5pmeitx+oPrfoEgBLA4n5QAHQi=+yOaKw@mail.gmail.com>
References: <20180526121125.25996-1-hch@lst.de>
 <CAK0tqim+wxwJ+KA+j5pmeitx+oPrfoEgBLA4n5QAHQi=+yOaKw@mail.gmail.com>
Message-ID: <20180528060015.GA3575@lst.de>


> > +static struct nvmet_port *nvme_loop_find_port(struct nvme_ctrl *ctrl)
> > +{
> > +       struct nvmet_port *p, *found = NULL;
> 
> [CK] Can we add a new line here to get rid of the checkpatch.pl warning?

Sure..
