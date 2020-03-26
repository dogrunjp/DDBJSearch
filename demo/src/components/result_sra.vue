<template>
    <section id="result" class="content">
        <div v-show="isStart" class="box is-primary has-text-centered result-box -start"><i class="fas fa-archive"></i>Let's search SRA entries!</div>
        <div v-show="isLoading" class="box is-info has-text-centered result-box -search"><i class="fas fa-spinner"></i>Now searching...</div>
        <div v-show="isError" class="box is-warning has-text-centered result-box -error"><i class="fas fa-sad-tear"></i>Sorry caused an error...</div>
        <div v-show="!isStart" class="search_loaded">
        </div>
    </section>
</template>
<script>
    export default {
        data() {
            return {
                isStart: false,
                isLoading: false,
                isError: false,
            }
        },
        mounted: function () {
            this.getData()
        },
        watch: {
            '$route': 'getData'
        },
        methods: {
            getData() {
                if (!Object.keys(this.$route.query).length) {
                    this.isStart = true
                    return
                } else {
                    this.isStart = false
                }
            }
        }
    }
</script>