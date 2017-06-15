From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Jun 2017 12:14:04 +0300
Subject: selftests: nvmftests: Introducing unittest framework for NVMe
 Over Fabricis
In-Reply-To: <20170612032610.4176-1-chaitanya.kulkarni@hgst.com>
References: <20170612032610.4176-1-chaitanya.kulkarni@hgst.com>
Message-ID: <c3a4f862-54eb-ceed-3284-9cca055f55ad@grimberg.me>

> Hi,
> 
> Introducing NVMe Over Fabrics unit test framework.
> 
> The goal is to have simple, lightweight, and easily expandable framework which can be used to
> develop various categories of unit tests for NVMe Over Fabrics and improve overall development.
> 
> Please have a look at README for an overview and process of adding a new test case.
> The framework also has a sample skeleton which can be used readily to write a new testcase.
> 
> I?d like to know what features, test cases are desirable for the framework.
> Any suggestions are welcome, I'd like to implement them.
> 
> On approval, I would like to submit more test cases to enhance the framework.

This looks great Chaitanya!

We have plenty of areas to cover :)

One of the most challenging flows for a fabric transport is network
errors injections while heavy IO is running, I think that this area
is the one that we tend to get wrong _and_ its the easiest one to break
because it usually involves non-trivial races.

This would need to somehow understand the network topology in some
json config I assume.

Extrapolating the above to have a many-hosts-to-one-target is probably
the hardest nut to crack in these sort of drivers. If we were able
to cover that, our nvmet quality instantly upgrades.

Note that I'm aware of multiple vendors that have these sort of testing
framework in-house so I hope they can contribute as well.
