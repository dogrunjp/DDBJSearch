<template>
    <header>
        <div id="header-link" class="navbar-inverse nav-upper">
            <div class="container-fluid content">
                <ul class="nav navbar-upper">
                    <li><a href="http://trace.ddbj.nig.ac.jp/dra/index.html"><i class="fas fa-external-link-alt" aria-hidden="true"></i> DRA Home </a></li>
                    <li><a href="http://getentry.ddbj.nig.ac.jp/top-e.html"><i class="fa fa-external-link-alt" aria-hidden="true"></i> DDBJ flat file search</a></li>
                </ul>
            </div>
        </div>
        <nav class="navbar" role="navigation" aria-label="main navigation">
            <div class="navbar-brand">
                <a class="navbar-item" href="/">
                    <img src="/assets/images/ddbj_logo.png" class="logo" alt="DDBJ Search"/><span class="title">DDBJ Search</span>
                </a>
            </div>
        </nav>

        <div class="tabs is-centered">
            <ul>
                <template v-for="(tab, index) in tabs">
                    <li :class="{'is-active': $route.path == tab.to }"  :key="index"><router-link :to="tab.to">{{ tab.label }}</router-link></li>
                </template>
            </ul>
        </div>

        <router-view></router-view>

    </header>
</template>
<script>
    var headerTabs = [
        {
            label: 'SRA',
            content: 'SRA Search.',
            displayed: true,
            to: '/'
        },
        {
            label: 'BioProject',
            content: 'BioProject Search.',
            displayed: true,
            to: '/bioproject'
        },
        {
            label: 'BioSample',
            content: 'BioSample Search.',
            displayed: true,
            to: '/biosample'
        },
        {
            label: 'Taxonomy',
            content: 'Taxonomy Search.',
            displayed: true,
            to: '/taxonomy'
        },
        {
            label: 'Publication',
            content: 'Publication Search.',
            displayed: true,
            to: '/publication'
        }
    ]

    export default {
        data() {
            return {
                activeTab: 3,
                tabs : headerTabs,
            }
        }
    }
</script>